import argparse
from collections import Counter, defaultdict
import json
from pathlib import Path
import sys


def build_candidates(inventory):
    if inventory.get('schemaVersion') != 1:
        raise ValueError('Unsupported source inventory schema')
    records = {}
    for row in inventory['spells']:
        key = (row['classId'], row['spellId'])
        if key in records or any(type(value) is not int or value <= 0 for value in key):
            raise ValueError('Invalid or duplicate class/spell identity')
        records[key] = row
    groups = defaultdict(set)
    references = defaultdict(list)
    for relation in inventory['relationships']:
        class_id = relation['classId']
        key = (class_id, relation['spellId'])
        root = (class_id, relation['referenceSpellId'])
        if key not in records or root not in records:
            raise ValueError('Relationship refers to an absent class/spell identity')
        if relation['meaning'] == 'claimed-root':
            groups[root].update((root[1], key[1]))
        elif relation['meaning'] == 'acquisition-reference':
            references[key].append(dict(relation))
        else:
            raise ValueError('Unknown relationship meaning')
    membership = defaultdict(set)
    for root, spells in groups.items():
        for spell in spells:
            membership[(root[0], spell)].add(root)
    for key in records:
        if key not in membership:
            groups[key].add(key[1])
    candidates = []
    for root, spells in sorted(groups.items()):
        claimed = root in membership
        members = [records[(root[0], spell)] for spell in sorted(spells)]
        flags = {'effective-data-unverified', 'practice-classification-unreviewed',
                 'claimed-chain-unverified' if claimed else 'unranked-kind-unreviewed'}
        acquisition = []
        for member in members:
            flags.update(member['reviewFlags'])
            key = (root[0], member['spellId'])
            if len(membership[key]) > 1:
                flags.add('conflicting-chain-membership')
            for relation in references[key]:
                acquisition.append(relation)
                if relation['referenceSpellId'] not in spells:
                    flags.add('external-acquisition-prerequisite')
        if claimed:
            if any(len(member['reportedLevels']) != 1 for member in members):
                flags.add('rank-order-unresolved')
            levels = [member['reportedLevels'][0] for member in members if len(member['reportedLevels']) == 1]
            if len(levels) != len(set(levels)):
                flags.add('shared-reported-levels')
            raw_ranks = [member.get('rawRankNumber') for member in members]
            if all(type(rank) is int and rank > 0 for rank in raw_ranks):
                if sorted(raw_ranks) != list(range(1, len(members) + 1)):
                    flags.add('claimed-chain-raw-rank-conflict')
            else:
                flags.add('claimed-chain-raw-ranks-unresolved')
        candidates.append({
            'classId': root[0], 'sourceReferenceSpellId': root[1],
            'sourceKind': 'claimed-root-group' if claimed else 'standalone-source',
            'classification': 'pending', 'productionApproved': False,
            'members': members,
            'acquisitionReferences': sorted(acquisition, key=lambda row: (
                row['spellId'], row['referenceSpellId'], row['source'])),
            'reviewFlags': sorted(flags),
        })
    counts = Counter(candidate['classId'] for candidate in candidates)
    return {
        'schemaVersion': 1, 'scope': 'source-review-candidates-not-runtime-definitions',
        'sources': inventory['sources'], 'dbcOrigin': inventory.get('dbcOrigin'),
        'summary': {
            'classCount': len(counts), 'candidateCount': len(candidates),
            'claimedRootGroupCount': sum(row['sourceKind'] == 'claimed-root-group' for row in candidates),
            'standaloneSourceCount': sum(row['sourceKind'] == 'standalone-source' for row in candidates),
            'conflictingMembershipCount': sum('conflicting-chain-membership' in row['reviewFlags']
                                             for row in candidates),
            'productionApprovedCount': 0,
        },
        'classes': [{'classId': class_id, 'candidateCount': count} for class_id, count in sorted(counts.items())],
        'candidates': candidates,
    }


def annotate_acquisition(candidates, lookup, sources):
    candidates['rawAcquisitionSources'] = sources
    for candidate in candidates['candidates']:
        nodes = {}
        for member in candidate['members']:
            for node in lookup(member['spellId']):
                nodes[node['id']] = node
        candidate['rawAcquisition'] = [nodes[identity] for identity in sorted(nodes)]
        if nodes:
            candidate['reviewFlags'] = sorted(set(candidate['reviewFlags']) | {
                'native-acquisition-filtering-unobserved'})
    candidates['summary']['withRawAcquisitionCount'] = sum(bool(row['rawAcquisition'])
                                                          for row in candidates['candidates'])
    return candidates


def load_acquisition_lookup(root, directory):
    sys.path.insert(0, str(root / 'apps/coa-dbc'))
    from inspect_dbc import DataSet
    dataset = DataSet(directory, root=root)
    loaded = {name: dataset.load(name) for name in (
        'CharacterAdvancement', 'CharacterAdvancementClassTypes', 'CharacterAdvancementTabTypes')}
    table, schema, index, _ = loaded['CharacterAdvancement']
    rank_fields = [field for field in schema.columns if field.name.startswith('RankSpell[')]
    if len(rank_fields) != 5:
        raise ValueError('Reviewed advancement schema must provide five rank spell fields')

    def record(name, identity):
        if identity not in loaded[name][2]:
            return {'id': identity, 'status': 'referenced record absent'}
        selected = dataset.record(name, identity)
        fields = [field for field in selected['fields'] if field['type'] != 'bytes']
        return {
            'values': {field['name']: field['value'] for field in fields},
            'fieldErrors': {field['name']: field['error'] for field in fields if 'error' in field},
        }

    nodes = defaultdict(list)
    for identity, row in sorted(index.items()):
        spells = set()
        for field in rank_fields:
            value, error = dataset.value(table, row, field)
            if error:
                raise ValueError('Invalid advancement rank spell field: ' + error)
            if value:
                spells.add(value)
        if not spells:
            continue
        node = record('CharacterAdvancement', identity)
        values = node['values']
        node.update({
            'id': identity, 'table': 'CharacterAdvancement',
            'classType': record('CharacterAdvancementClassTypes', values['ClassType']),
            'tab': record('CharacterAdvancementTabTypes', values['Tab']),
            'scope': 'raw-data-reference-not-character-entitlement',
        })
        for spell in spells:
            nodes[spell].append(node)
    sources = [{'table': name, 'origin': loaded[name][3]} for name in sorted(loaded)]
    return lambda spell: nodes.get(spell, []), sources


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--inventory', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--dbc', type=Path)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    result = build_candidates(json.loads(args.inventory.read_text(encoding='utf-8')))
    if args.dbc:
        lookup, sources = load_acquisition_lookup(args.root, args.dbc)
        annotate_acquisition(result, lookup, sources)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
