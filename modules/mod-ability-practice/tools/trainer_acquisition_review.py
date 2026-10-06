import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re

from profile_drafts import verify_provenance


TRAINER_SQL = 'data/sql/updates/pending_db_world/rev_20260923_05_coa_class_trainer_core.sql'
REVIEW_SOURCES = (
    TRAINER_SQL,
    'src/server/game/Entities/Creature/Trainer.h',
    'src/server/game/Entities/Creature/Trainer.cpp',
    'modules/mod-ability-practice/tools/trainer_acquisition_review.py',
)


def insert_bodies(text, table, columns):
    pattern = r'INSERT\s+INTO\s+`' + re.escape(table) + r'`\s*\(([^)]*)\)\s*VALUES\s*(.*?);'
    matches = list(re.finditer(pattern, text, re.DOTALL | re.IGNORECASE))
    if not matches:
        raise ValueError('Missing source INSERT for ' + table)
    bodies = []
    for match in matches:
        actual = [value.strip().strip('`') for value in match.group(1).split(',')]
        if actual != columns:
            raise ValueError('Changed source INSERT columns for ' + table)
        bodies.append(re.sub(r'--[^\n]*', '', match.group(2)))
    return bodies


def strict_rows(body, pattern):
    matches = list(re.finditer(pattern, body))
    if not matches or re.sub(pattern, '', body).strip(' \t\r\n,'):
        raise ValueError('Unsupported or empty source INSERT values')
    return matches


def source_trainers(root):
    text = (root / TRAINER_SQL).read_text(encoding='utf-8-sig')
    owners = {}
    owner_pattern = r"\(\s*(\d+),\s*(\d+),\s*(\d+),\s*'(?:[^'\\]|\\.|'')*'\s*\)"
    for body in insert_bodies(text, 'trainer', ['Id', 'Type', 'Requirement', 'Greeting']):
        for match in strict_rows(body, owner_pattern):
            trainer_id, trainer_type, requirement = map(int, match.groups())
            if trainer_id in owners or trainer_type != 0 or not 12 <= requirement <= 32:
                raise ValueError('Duplicate or unsupported class trainer owner')
            owners[trainer_id] = requirement
    columns = ['TrainerId', 'SpellId', 'MoneyCost', 'ReqSkillLine', 'ReqSkillRank',
               'ReqAbility1', 'ReqAbility2', 'ReqAbility3', 'ReqLevel']
    pattern = r'\(\s*' + r'\s*,\s*'.join([r'(\d+)'] * len(columns)) + r'\s*\)'
    offers, seen = defaultdict(list), set()
    for body in insert_bodies(text, 'trainer_spell', columns):
        for match in strict_rows(body, pattern):
            values = list(map(int, match.groups()))
            trainer_id, spell_id, cost, skill, skill_rank, first, second, third, level = values
            if trainer_id not in owners or (trainer_id, spell_id) in seen or not spell_id or not 1 <= level <= 255:
                raise ValueError('Invalid or duplicate class trainer spell')
            if any(value > 4294967295 for value in values):
                raise ValueError('Source trainer value exceeds native range')
            seen.add((trainer_id, spell_id))
            offers[(owners[trainer_id], spell_id)].append({
                'trainerId': trainer_id, 'spellId': spell_id, 'characterLevel': level, 'moneyCost': cost,
                'requiredSkillLine': skill, 'requiredSkillRank': skill_rank,
                'requiredAbilities': [value for value in (first, second, third) if value],
            })
    return owners, offers


def rift_mappings(root):
    text = (root / 'src/server/coa/AscensionFelswornData.h').read_text(encoding='utf-8')
    arrays = list(re.finditer(r'constexpr\s+FelswornRift\s+FelswornRifts\[\]\s*=\s*\{(.*?)\};',
                             text, re.DOTALL))
    if len(arrays) != 1:
        raise ValueError('Missing or ambiguous native rift mappings')
    floating = r'-?\d+\.\d+f'
    pattern = (r'\{\s*(\d+),\s*(\d+),\s*(\d+),\s*' +
               r'\s*,\s*'.join([floating] * 4) + r'\s*,\s*\d+\s*\}')
    result = {}
    for match in strict_rows(arrays[0].group(1), pattern):
        spell_id, entry, map_id = map(int, match.groups())
        if spell_id in result or not entry:
            raise ValueError('Duplicate or invalid native rift mapping')
        result[spell_id] = {'gameObjectEntry': entry, 'mapId': map_id}
    return result


def supplemental_ladders(candidates, offers, supplemental):
    records, references, native_roots = {}, defaultdict(set), set()
    for candidate in candidates['candidates']:
        class_id = candidate['classId']
        if candidate['nativeClassGrantReview'].get('sourceChainConsistent') is True:
            native_roots.add((class_id, candidate['sourceReferenceSpellId']))
        for member in candidate['members']:
            identity = (class_id, member['spellId'])
            if identity in records and records[identity] != member:
                raise ValueError('Conflicting source identity while reviewing trainer ladders')
            records[identity] = member
        for relation in candidate['acquisitionReferences']:
            references[(class_id, relation['spellId'])].add((class_id, relation['referenceSpellId']))
        if candidate['sourceKind'] == 'claimed-root-group':
            root = (class_id, candidate['sourceReferenceSpellId'])
            for member in candidate['members']:
                identity = (class_id, member['spellId'])
                if identity != root:
                    references[identity].add(root)
    parents = {identity: identity for identity in records}

    def component(identity):
        while parents[identity] != identity:
            parents[identity] = parents[parents[identity]]
            identity = parents[identity]
        return identity

    links = []
    for identity, prerequisites in sorted(references.items()):
        member = records[identity]
        rank = member.get('rawRankNumber')
        name = member.get('rawDbc', {}).get('name')
        for previous in sorted(prerequisites):
            before = records.get(previous, {})
            earlier_rank = before.get('rawRankNumber')
            if (type(rank) is not int or type(earlier_rank) is not int or not 1 <= earlier_rank < rank
                    or not name or before.get('rawDbc', {}).get('name') != name):
                continue
            parents[component(identity)] = component(previous)
            links.append({'classId': identity[0], 'spellId': identity[1], 'requiredSpellId': previous[1]})
    groups = defaultdict(list)
    for identity in records:
        groups[component(identity)].append(identity)
    reviewed = {(row['classId'], member['spellId']) for row in supplemental for member in row['members']
                if member['capturedLevels']}
    result = []
    for identities in groups.values():
        if len(identities) < 2 or not reviewed.intersection(identities):
            continue
        identities.sort(key=lambda identity: (records[identity]['rawRankNumber'], identity))
        flags, ranks = set(), []
        raw_ranks = [records[identity]['rawRankNumber'] for identity in identities]
        if raw_ranks != list(range(1, len(identities) + 1)):
            flags.add('raw-rank-sequence-incomplete-or-conflicting')
        for identity in identities:
            member = records[identity]
            evidence = offers.get(identity, [])
            if len(evidence) != 1:
                flags.add('missing-or-ambiguous-source-trainer-offer')
            levels = {entry['characterLevel'] for entry in evidence}
            level = next(iter(levels)) if len(levels) == 1 else None
            if level not in member.get('reportedLevels', []):
                flags.add('source-trainer-and-inventory-level-conflict')
            ranks.append({'spellId': identity[1], 'rankNumber': member['rawRankNumber'],
                          'characterLevel': level, 'sourceTrainerOffers': evidence})
        levels = [rank['characterLevel'] for rank in ranks]
        if any(level is None for level in levels) or any(later < earlier for earlier, later in
                                                       zip(levels, levels[1:]) if None not in (earlier, later)):
            flags.add('source-trainer-level-order-unresolved')
        root = identities[0]
        selected_links = [link for link in links if (link['classId'], link['spellId']) in identities]
        result.append({'classId': root[0], 'firstObservedSpellId': root[1],
                       'name': records[root]['rawDbc']['name'],
                       'hasSourceConsistentClassGrantRoot': root in native_roots,
                       'status': 'blocked-by-source-evidence' if flags else
                                 'needs-effective-chain-and-acquisition-review',
                       'blockingFlags': sorted(flags), 'ranks': ranks, 'acquisitionLinks': selected_links,
                       'scope': 'same-name-ordered-ranks-linked-by-source-references-not-native-rank-chain',
                       'runtimeQualified': False, 'productionApproved': False})
    return sorted(result, key=lambda row: (row['classId'], row['firstObservedSpellId']))


def source_trainer_rank_audit(candidates, offers):
    records, roots = {}, {}
    for candidate in candidates['candidates']:
        class_id = candidate['classId']
        for member in candidate['members']:
            identity = (class_id, member['spellId'])
            if identity in records and records[identity] != member:
                raise ValueError('Conflicting captured member in trainer rank audit')
            records[identity] = member
        review = candidate['nativeClassGrantReview']
        if review.get('sourceChainConsistent') is True and len(review['sourceRanks']) > 1:
            identity = (class_id, candidate['sourceReferenceSpellId'])
            if identity in roots and roots[identity] != review['sourceRanks']:
                raise ValueError('Conflicting native prefix in trainer rank audit')
            roots[identity] = review['sourceRanks']
    rows = []
    for identity, prefix in sorted(roots.items()):
        name = records[identity].get('rawDbc', {}).get('name')
        if not name:
            raise ValueError('Missing captured native root name in trainer rank audit')
        ranks, flags = [], set()
        for offered, evidence in sorted(offers.items()):
            member = records.get(offered, {})
            raw = member.get('rawDbc', {})
            if offered[0] != identity[0] or raw.get('name') != name:
                continue
            number = member.get('rawRankNumber')
            if type(number) is not int or number < 1 or raw.get('fieldErrors'):
                flags.add('missing-or-invalid-ranked-raw-evidence')
            if len(evidence) != 1:
                flags.add('missing-or-ambiguous-source-trainer-offer')
            level = evidence[0]['characterLevel'] if len(evidence) == 1 else None
            if level not in member.get('reportedLevels', []):
                flags.add('source-trainer-and-inventory-level-conflict')
            prerequisites = sorted({value for offer in evidence for value in offer['requiredAbilities']})
            if any(offer['requiredSkillLine'] or offer['requiredSkillRank'] for offer in evidence):
                flags.add('additional-native-skill-gate')
            links = [{'spellId': value,
                      'capturedName': records.get((identity[0], value), {}).get('rawDbc', {}).get('name')}
                     for value in prerequisites]
            if any(link['capturedName'] != name for link in links):
                flags.add('different-ability-or-uncaptured-prerequisite')
            ranks.append({'spellId': offered[1], 'rankNumber': number, 'characterLevel': level,
                          'sourceTrainerOffers': evidence, 'prerequisiteIdentities': links})
        ranks.sort(key=lambda rank: (rank['rankNumber'] if type(rank['rankNumber']) is int else 0,
                                     rank['spellId']))
        if [rank['rankNumber'] for rank in ranks] != list(range(1, len(ranks) + 1)):
            flags.add('raw-rank-sequence-incomplete-or-conflicting')
        projected_prefix = [{key: rank[key] for key in ('spellId', 'characterLevel')} for rank in
                            ranks[:len(prefix)]]
        expected_prefix = [{key: rank[key] for key in ('spellId', 'characterLevel')} for rank in prefix]
        if projected_prefix != expected_prefix:
            flags.add('source-trainer-and-native-prefix-disagree')
        levels = [rank['characterLevel'] for rank in ranks]
        if any(level is None for level in levels) or any(later < earlier for earlier, later in
                                                       zip(levels, levels[1:]) if None not in (earlier, later)):
            flags.add('source-trainer-level-order-unresolved')
        for index, rank in enumerate(ranks):
            expected = [ranks[index - 1]['spellId']] if index else []
            if [link['spellId'] for link in rank['prerequisiteIdentities']] != expected:
                flags.add('trainer-prerequisite-differs-from-immediate-rank')
        rows.append({'classId': identity[0], 'abilityId': identity[1], 'name': name,
                     'nativePrefix': prefix, 'sameNameSourceTrainerRanks': ranks,
                     'blockingFlags': sorted(flags),
                     'status': 'requires-source-gate-review' if flags else 'needs-effective-trainer-review',
                     'scope': 'same-name-source-trainer-audit-not-acquisition-link',
                     'runtimeQualified': False, 'productionApproved': False})
    return rows


def build_review(candidates, owners, offers, mappings):
    if candidates.get('schemaVersion') != 1 or candidates.get('scope') != (
            'source-review-candidates-not-runtime-definitions'):
        raise ValueError('Unsupported source candidates')
    rows = []
    for candidate in candidates['candidates']:
        if candidate['nativeClassGrantReview'].get('sourceChainConsistent') is True:
            continue
        class_id, root_spell = candidate['classId'], candidate['sourceReferenceSpellId']
        if not any((class_id, member['spellId']) in offers for member in candidate['members']):
            continue
        flags, members = set(), []
        for member in candidate['members']:
            spell_id = member['spellId']
            evidence = offers.get((class_id, spell_id), [])
            captured = [entry for entry in member['evidence'] if entry['source'] in
                        {'captured-offers', 'authored-trainer', 'recovered-ranks'}
                        and not entry.get('referenceOnly')]
            levels = {entry.get('requiredLevel') for entry in captured}
            if len(evidence) != 1:
                flags.add('missing-or-ambiguous-source-trainer-offer')
            elif levels != {evidence[0]['characterLevel']}:
                flags.add('captured-and-sql-level-evidence-conflict-or-missing')
            raw = member.get('rawDbc', {})
            if raw.get('fieldErrors') or type(raw.get('passive')) is not bool:
                flags.add('missing-or-invalid-raw-spell-evidence')
            elif raw['passive']:
                flags.add('passive-ability-requires-individual-review')
            references = sorted({entry['referenceSpellId'] for entry in candidate['acquisitionReferences']
                                 if entry['spellId'] == spell_id})
            prerequisites = sorted({value for entry in evidence for value in entry['requiredAbilities']})
            if references != prerequisites:
                flags.add('captured-and-sql-prerequisite-evidence-conflict')
            value = {'spellId': spell_id, 'name': raw.get('name'), 'sourceTrainerOffers': evidence,
                     'capturedLevels': sorted(level for level in levels if type(level) is int),
                     'capturedPrerequisites': references, 'rawEffects': raw.get('effects'),
                     'rawPassive': raw.get('passive')}
            if class_id == 14 and 535595 <= spell_id <= 535605:
                value['nativeRiftMapping'] = mappings.get(spell_id)
                if spell_id not in mappings:
                    flags.add('missing-explicit-native-rift-mapping')
            members.append(value)
        if 'tree-acquisition-gate' in candidate['reviewFlags']:
            flags.add('tree-acquisition-gate-requires-review')
        rows.append({'classId': class_id, 'sourceReferenceSpellId': root_spell,
                     'status': 'blocked-by-source-evidence' if flags else 'needs-effective-trainer-and-design-review',
                     'blockingFlags': sorted(flags), 'members': members,
                     'runtimeQualified': False, 'productionApproved': False})
    ladders = supplemental_ladders(candidates, offers, rows)
    audit = source_trainer_rank_audit(candidates, offers)
    captured = {(candidate['classId'], member['spellId']) for candidate in candidates['candidates']
                for member in candidate['members']}
    uncaptured = [{'classId': identity[0], 'spellId': identity[1], 'sourceTrainerOffers': evidence}
                  for identity, evidence in sorted(offers.items()) if identity not in captured]
    return {'schemaVersion': 1, 'scope': 'supplemental-trainer-source-review-not-native-entitlement',
            'runtimeQualified': False, 'productionApproved': False,
            'requiredEffectiveReview': ['loaded-class-trainer-owner-and-offer', 'native-rank-chain',
                                        'race-faction-and-tree-eligibility', 'trainer-learn-wrapper-behavior',
                                        'individual-practice-or-fixed-design'],
            'summary': {'sourceClassTrainers': len(owners),
                        'sourceTrainerOffers': sum(len(value) for value in offers.values()),
                        'supplementalCandidates': len(rows),
                        'statuses': dict(sorted(Counter(row['status'] for row in rows).items())),
                        'supplementalRankLadders': len(ladders),
                        'sourceTrainerRankAudits': len(audit),
                        'sourceTrainerRankAuditFlags': dict(sorted(Counter(flag for row in audit
                                                                          for flag in row['blockingFlags']).items())),
                        'uncapturedSourceTrainerOffers': len(uncaptured),
                        'supplementalRankLadderStatuses': dict(sorted(Counter(row['status']
                                                                            for row in ladders).items())),
                        'blockingFlags': dict(sorted(Counter(flag for row in rows
                                                           for flag in row['blockingFlags']).items()))},
            'candidates': rows, 'rankLadders': ladders, 'sourceTrainerRankAudits': audit,
            'uncapturedSourceTrainerOffers': uncaptured}


def declared_rank_boundaries(review, declarations):
    rows = []
    for ladder in review['rankLadders']:
        identity = (ladder['classId'], ladder['firstObservedSpellId'])
        declaration = declarations.get(identity)
        if not declaration or declaration['kind'] == 'fixed':
            continue
        authored = declaration['authoredRanks']
        known = {rank['spellId'] for rank in authored}
        extra = [rank for rank in ladder['ranks'] if rank['spellId'] not in known and
                 rank['rankNumber'] > authored[-1]['rankNumber']]
        if not extra:
            continue
        rows.append({'classId': identity[0], 'abilityId': identity[1], 'name': ladder['name'],
                     'declaredKind': declaration['kind'], 'authoredRanks': authored,
                     'unprofiledLinkedHigherRanks': extra, 'sourceLadderStatus': ladder['status'],
                     'sourceLadderBlockingFlags': ladder['blockingFlags'],
                     'decision': 'reject-incomplete-practice-catalog-until-fully-authored',
                     'scope': 'source-linked-higher-rank-boundary-not-loaded-trainer-proof',
                     'runtimeQualified': False, 'productionApproved': False})
    return rows


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    parser.add_argument('--candidates', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    root, dbc = args.root.resolve(), args.dbc.resolve()
    candidates = json.loads(args.candidates.read_text(encoding='utf-8'))
    verify_provenance(candidates, root, dbc)
    owners, offers = source_trainers(root)
    result = build_review(candidates, owners, offers, rift_mappings(root))
    from coverage import declared_profiles
    result['practiceProfileTrainerRankBoundaries'] = declared_rank_boundaries(result, declared_profiles(root))
    result['summary']['practiceProfileTrainerExtensionCount'] = len(result['practiceProfileTrainerRankBoundaries'])
    result['summary']['unprofiledLinkedHigherRankCount'] = sum(
        len(row['unprofiledLinkedHigherRanks']) for row in result['practiceProfileTrainerRankBoundaries'])
    sources = candidates['sources'] + candidates['nativeOutcomeSources'] + [
        {'path': relative, 'sha256': hashlib.sha256((root / relative).read_bytes()).hexdigest()}
        for relative in REVIEW_SOURCES]
    unique = {}
    for source in sources:
        if source['path'] in unique and unique[source['path']] != source:
            raise ValueError('Conflicting trainer review source provenance')
        unique[source['path']] = source
    result['sources'] = [unique[path] for path in sorted(unique)]
    result['dbcOrigin'] = candidates['dbcOrigin']
    result['inputSha256'] = hashlib.sha256(args.candidates.read_bytes()).hexdigest()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
