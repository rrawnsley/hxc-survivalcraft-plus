import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import sys


SOURCES = (
    ('class-grants', 'src/server/coa/AscensionCustomClassData.h', 'ClassSpells',
     ('class', 'level', 'spell'), None),
    ('generated-progression', 'src/server/coa/AscensionSpellProgressionData.h', 'Ranks',
     ('class', 'reference', 'spell', 'level'), 'claimed-root'),
    ('captured-offers', 'modules/mod-spellbook/src/SpellbookOfferData.h', 'Offers',
     ('class', 'level', 'reference', 'spell'), 'acquisition-reference'),
    ('authored-trainer', 'modules/mod-spellbook/src/SpellbookTrainerData.h', 'Offers',
     ('class', 'level', 'reference', 'spell'), 'acquisition-reference'),
    ('recovered-ranks', 'modules/mod-spellbook/src/SpellbookRankData.h', 'Ranks',
     ('class', 'level', 'rank', 'reference', 'spell'), 'acquisition-reference'),
    ('tree-grants', 'modules/mod-spellbook/src/SpellbookTreeSpellData.h', 'TreeSpells',
     ('class', 'spell'), None),
)


def read_rows(text, array_name, columns):
    pattern = (r'inline\s+constexpr\s+std::array<[^,>]+,\s*(\d+)>\s+' + re.escape(array_name) +
               r'\s*=\s*\{\{(.*?)\}\};')
    declarations = list(re.finditer(pattern, text, re.DOTALL))
    if len(declarations) != 1:
        raise ValueError('Expected one array declaration for ' + array_name)
    declaration = declarations[0]
    body = re.sub(r'//[^\n]*', '', declaration.group(2))
    row_pattern = r'\{\s*(\d+(?:\s*,\s*\d+)*)\s*\}'
    matches = list(re.finditer(row_pattern, body))
    remainder = re.sub(row_pattern, '', body)
    if remainder.strip(' \t\r\n,'):
        raise ValueError('Unsupported array contents in ' + array_name)
    if len(matches) != int(declaration.group(1)):
        raise ValueError('Declared row count does not match ' + array_name)
    rows = []
    for match in matches:
        values = [int(value.strip()) for value in match.group(1).split(',')]
        if len(values) != len(columns):
            raise ValueError('Column count does not match ' + array_name)
        row = dict(zip(columns, values))
        if not row['class'] or not row['spell']:
            raise ValueError('Invalid class or spell identity in ' + array_name)
        rows.append(row)
    return rows


def build_inventory(root):
    records = {}
    provenance = []
    relationships = []

    def record(class_id, spell_id):
        return records.setdefault((class_id, spell_id), {
            'classId': class_id, 'spellId': spell_id, 'evidence': [],
        })

    for source, relative, array_name, columns, relation in SOURCES:
        path = root / relative
        content = path.read_bytes()
        rows = read_rows(content.decode('utf-8-sig'), array_name, columns)
        provenance.append({
            'source': source, 'path': relative, 'array': array_name, 'rows': len(rows),
            'sha256': hashlib.sha256(content).hexdigest(),
        })
        for row in rows:
            evidence = {'source': source}
            if 'level' in row:
                evidence['requiredLevel'] = row['level']
            if 'rank' in row:
                evidence['rankNumber'] = row['rank']
            record(row['class'], row['spell'])['evidence'].append(evidence)
            if row.get('reference'):
                record(row['class'], row['reference'])['evidence'].append({
                    'source': source, 'referenceOnly': True,
                })
                relationships.append({
                    'classId': row['class'], 'spellId': row['spell'], 'referenceSpellId': row['reference'],
                    'meaning': relation, 'source': source,
                })

    roots = {}
    for relationship in relationships:
        if relationship['meaning'] == 'claimed-root':
            key = (relationship['classId'], relationship['spellId'])
            roots.setdefault(key, set()).add(relationship['referenceSpellId'])

    classes = Counter()
    flags = Counter()
    spells = []
    for key, entry in sorted(records.items()):
        levels = sorted({item['requiredLevel'] for item in entry['evidence'] if 'requiredLevel' in item})
        entry['reportedLevels'] = levels
        entry['reviewFlags'] = ['effective-data-unverified', 'practice-classification-unreviewed']
        if len(levels) > 1:
            entry['reviewFlags'].append('conflicting-level-evidence')
        if not levels:
            entry['reviewFlags'].append('level-unresolved')
        if any(item['source'] == 'tree-grants' for item in entry['evidence']):
            entry['reviewFlags'].append('tree-acquisition-gate')
        if len(roots.get(key, ())) > 1:
            entry['reviewFlags'].append('conflicting-claimed-roots')
        classes[entry['classId']] += 1
        flags.update(entry['reviewFlags'])
        spells.append(entry)

    return {
        'schemaVersion': 1,
        'scope': 'source-evidence-only-not-an-approved-practice-catalog',
        'summary': {
            'classCount': len(classes), 'classSpellCount': len(spells),
            'relationshipCount': len(relationships), 'reviewFlags': dict(sorted(flags.items())),
        },
        'classes': [{'classId': class_id, 'spellCount': count} for class_id, count in sorted(classes.items())],
        'sources': provenance,
        'spells': spells,
        'relationships': relationships,
    }


def annotate_dbc(inventory, lookup, origin):
    inventory['dbcOrigin'] = origin
    groups = {}
    for entry in inventory['spells']:
        evidence = lookup(entry['spellId'])
        if evidence is None:
            entry['reviewFlags'].append('missing-raw-dbc-record')
            continue
        entry['rawDbc'] = evidence
        if evidence.get('passive'):
            entry['reviewFlags'].append('raw-dbc-passive-review')
        if evidence.get('fieldErrors'):
            entry['reviewFlags'].append('raw-dbc-field-errors')
        if origin.get('manifest_match') is False:
            entry['reviewFlags'].append('stale-extraction-manifest')
        elif origin.get('manifest_match') is None:
            entry['reviewFlags'].append('unknown-extraction-origin')
        label = evidence.get('rankLabel') or ''
        match = re.fullmatch(r'Rank\s+(\d+)', label)
        if match and int(match.group(1)) > 0:
            entry['rawRankNumber'] = int(match.group(1))
            key = (entry['classId'], evidence.get('name') or '')
            groups.setdefault(key, []).append({
                'spellId': entry['spellId'], 'rawRankNumber': entry['rawRankNumber'],
            })
    inventory['nameRankCandidates'] = [
        {'classId': class_id, 'name': name, 'members': sorted(members, key=lambda row: (
            row['rawRankNumber'], row['spellId'])), 'scope': 'name-and-label-candidate-not-verified-ability-identity'}
        for (class_id, name), members in sorted(groups.items()) if name and len(members) > 1
    ]
    counts = Counter(flag for entry in inventory['spells'] for flag in entry['reviewFlags'])
    inventory['summary']['reviewFlags'] = dict(sorted(counts.items()))
    inventory['summary']['nameRankCandidateCount'] = len(inventory['nameRankCandidates'])
    return inventory


def load_dbc_lookup(root, directory):
    sys.path.insert(0, str(root / 'apps/coa-dbc'))
    from inspect_dbc import DataSet
    dataset = DataSet(directory, root=root)
    table, schema, index, origin = dataset.load('Spell')
    names = ('SpellName[enUS]', 'Rank[enUS]', 'Attributes', 'BaseLevel', 'SpellLevel',
             'Effect[0]', 'Effect[1]', 'Effect[2]')
    columns = {field.name: field for field in schema.columns}
    if any(name not in columns for name in names):
        raise ValueError('Reviewed Spell schema is missing a required inventory field')
    passive = next(value for value, label in dataset.enums['SpellAttr0'].items() if label == 'SPELL_ATTR0_PASSIVE')

    def lookup(spell_id):
        if spell_id not in index:
            return None
        values, errors = {}, {}
        for name in names:
            value, error = dataset.value(table, index[spell_id], columns[name])
            values[name] = value
            if error:
                errors[name] = error
        result = {
            'name': values['SpellName[enUS]'], 'rankLabel': values['Rank[enUS]'],
            'baseLevel': values['BaseLevel'], 'spellLevel': values['SpellLevel'],
            'attributes': values['Attributes'], 'passive': bool(values['Attributes'] & passive),
            'effects': [values['Effect[' + str(effect) + ']'] for effect in range(3)],
        }
        if errors:
            result['fieldErrors'] = errors
        return result

    return lookup, origin


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--dbc', type=Path)
    arguments = parser.parse_args()
    inventory = build_inventory(arguments.root)
    if arguments.dbc:
        lookup, origin = load_dbc_lookup(arguments.root, arguments.dbc)
        annotate_dbc(inventory, lookup, origin)
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(json.dumps(inventory, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(inventory['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
