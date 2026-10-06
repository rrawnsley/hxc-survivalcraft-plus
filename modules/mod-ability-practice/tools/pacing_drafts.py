import argparse
import hashlib
import json
import sys
from pathlib import Path

from coverage import declared_profiles, validate_rank_agreement
from profile_drafts import verify_provenance


def load_cast_times(root, directory):
    sys.path.insert(0, str(root / 'apps/coa-dbc'))
    from inspect_dbc import DataSet
    dataset = DataSet(directory, root=root)
    table, schema, index, origin = dataset.load('SpellCastTimes')
    field = next(value for value in schema.columns if value.name == 'CastTime')
    values = {}
    for identity, row in index.items():
        value, error = dataset.value(table, row, field)
        if error or type(value) is not int:
            raise ValueError('Invalid raw cast duration: ' + str(identity))
        values[identity] = value
    return values, origin


def load_cadences(path, drafts):
    if path is None:
        return {}, None
    raw = path.read_bytes()
    document = json.loads(raw)
    if not isinstance(document, dict) or set(document) != {'schemaVersion', 'scope', 'abilities'} or (
            type(document['schemaVersion']) is not int or document['schemaVersion'] != 1 or
            document['scope'] != 'authored-cadence-assumptions-not-measured-frequency' or
            not isinstance(document['abilities'], list)):
        raise ValueError('Invalid authored cadence document')
    ranked = {(draft['classId'], draft['abilityId']) for draft in drafts['drafts'] if len(draft['ranks']) > 1}
    result = {}
    for value in document['abilities']:
        fields = {'classId', 'abilityId', 'assumedUseIntervalMilliseconds', 'reason'}
        if not isinstance(value, dict) or set(value) != fields:
            raise ValueError('Invalid authored cadence entry')
        identity = (value['classId'], value['abilityId'])
        if any(type(number) is not int or not 1 <= number <= 4294967295 for number in identity) or (
                identity not in ranked or identity in result):
            raise ValueError('Unknown or duplicate ranked cadence identity')
        interval, reason = value['assumedUseIntervalMilliseconds'], value['reason']
        if type(interval) is not int or not 1 <= interval <= 86400000 or not isinstance(reason, str) or (
                not reason.strip() or len(reason.encode('utf-8')) > 240 or
                any(ord(character) < 32 for character in reason)):
            raise ValueError('Invalid cadence interval or reason')
        result[identity] = value
    return result, {'file': str(path.resolve()), 'sha256': hashlib.sha256(raw).hexdigest(),
                    'scope': document['scope']}


def build_pacing(drafts, minimum_minutes, target_minutes, maximum_minutes, common_interval,
                 cast_times, cast_time_origin, cadences, cadence_origin, declarations):
    if drafts.get('scope') != 'unapproved-definition-drafts-not-runtime-profiles' or (
            drafts.get('productionApproved') is not False):
        raise ValueError('Expected unapproved source-consistent drafts')
    if not 1 <= minimum_minutes <= target_minutes <= maximum_minutes <= 1440 or not (
            1 <= common_interval <= 86400000):
        raise ValueError('Invalid draft pacing target')
    proposals, seen = [], set()
    for draft in drafts['drafts']:
        identity = (draft['classId'], draft['abilityId'])
        if identity in seen:
            raise ValueError('Duplicate ability identity')
        seen.add(identity)
        ranks = draft['ranks']
        if len(ranks) < 2:
            continue
        declaration = declarations.get(identity)
        if declaration and declaration['kind'] != 'ranked':
            raise ValueError('Pacing requires a ranked declared profile: ' + str(identity))
        validate_rank_agreement(draft, declaration)
        cadence = cadences.get(identity)
        cadence_interval = cadence['assumedUseIntervalMilliseconds'] if cadence else common_interval
        bands, transitions = [], []
        for index in range(1, len(ranks)):
            previous, upcoming = ranks[index - 1], ranks[index]
            timing = previous.get('rawCastProfile')
            if not timing or timing.get('scope') != 'raw-dbc-timing-not-measured-use-frequency':
                raise ValueError('Missing raw timing for ranked ability: ' + str(identity))
            intervals = [timing[field] for field in ('recoveryMilliseconds', 'categoryRecoveryMilliseconds',
                                                    'startRecoveryMilliseconds')]
            if any(type(value) is not int or not 0 <= value <= 4294967295 for value in intervals):
                raise ValueError('Invalid raw recovery value')
            cast_index = timing['castingTimeIndex']
            if type(cast_index) is not int or not 0 <= cast_index <= 4294967295:
                raise ValueError('Invalid raw casting-time index')
            if cast_index and cast_index not in cast_times:
                raise ValueError('Missing raw casting-time record: ' + str(cast_index))
            raw_cast_time = cast_times[cast_index] if cast_index else 0
            recovery = max(timing['recoveryMilliseconds'], timing['categoryRecoveryMilliseconds'])
            sequential_floor = max(0, raw_cast_time) + recovery
            interval = max(cadence_interval, timing['startRecoveryMilliseconds'], sequential_floor)
            previous_proficiency = 1 if index == 1 else 10 if index == 2 else (index - 2) * 20
            proficiency = 10 if index == 1 else (index - 1) * 20
            delta = proficiency - previous_proficiency
            uses = max(1, (target_minutes * 60000 + interval // 2) // interval)
            milliseconds = uses * interval
            bands.append({'firstProficiency': previous_proficiency, 'pointsPerLevel': uses * 30,
                          'pointsPerUse': delta * 30})
            transitions.append({'practicedSpellId': previous['spellId'], 'nextSpellId': upcoming['spellId'],
                                'nextRankNumber': upcoming['rankNumber'],
                                'requiredCharacterLevel': upcoming['characterLevel'],
                                'requiredProficiency': proficiency, 'proficiencyDelta': delta,
                                'assumedUseIntervalMilliseconds': interval,
                                'assumptionSource': 'maximum-cast-then-raw-recovery-global-recovery-or-authored-cadence-floor',
                                'castingTimeIndex': cast_index,
                                'rawBaseCastMilliseconds': raw_cast_time,
                                'rawRecoveryAfterCastMilliseconds': recovery,
                                'rawCastAndRecoveryFloorMilliseconds': sequential_floor,
                                'cooldownLifecycleExceptionsResolved': False,
                                'baselineUsesFromPriorThresholdAndZeroPartial': uses,
                                'estimatedBaselineCombatMilliseconds': milliseconds,
                                'withinAssumedTargetWindow': minimum_minutes * 60000 <= milliseconds <= (
                                    maximum_minutes * 60000),
                                'effectiveCastingTimeMeasured': False})
        proposals.append({'classId': identity[0], 'abilityId': identity[1],
                          'nameFromRawDbc': ranks[0]['nameFromRawDbc'], 'definitionVersion': None,
                          'productionApproved': False, 'runtimeQualified': False,
                          'requiresSavedProgressMigrationReview': True,
                          'existingDevelopmentDeclaration': declaration,
                          'sourceRankAgreementWithDeclaredProfile': True if declaration else None,
                          'proposedTrainingBands': bands,
                          'transitions': transitions,
                          'requiredReviews': sorted(set(draft['requiredReviews']) |
                                                    {'native-cooldown-and-channel-lifecycle'}),
                          'reviewFlags': draft['reviewFlags'],
                          'assumedCadenceMilliseconds': cadence_interval,
                          'cadenceSource': 'authored-ability-assumption' if cadence else 'common-default-assumption',
                          'cadenceReason': cadence['reason'] if cadence else None})
    proposals.sort(key=lambda value: (value['classId'], value['abilityId']))
    return {'schemaVersion': 1, 'scope': 'unapproved-pacing-proposals-not-native-policy-or-measured-duration',
            'productionApproved': False, 'runtimeQualified': False,
            'minimumRankMinutes': minimum_minutes, 'targetRankMinutes': target_minutes,
            'maximumRankMinutes': maximum_minutes, 'assumedCommonUseIntervalMilliseconds': common_interval,
            'catchupIncluded': False, 'characterLevelWaitIncluded': False,
            'effectiveCooldownModifiersIncluded': False, 'effectiveCastingModifiersIncluded': False,
            'channelDurationIncluded': False, 'cooldownLifecycleExceptionsResolved': False,
            'measuredUseFrequency': False,
            'unrankedRewardsTuned': False, 'partialCreditScale': 30,
            'savedProgressMigrationImplemented': False, 'sources': drafts['sources'],
            'nativeOutcomeSources': drafts['nativeOutcomeSources'], 'dbcOrigin': drafts['dbcOrigin'],
            'castTimeDbcOrigin': cast_time_origin, 'authoredCadenceOrigin': cadence_origin,
            'summary': {'rankedProposalCount': len(proposals),
                        'transitionCount': sum(len(value['transitions']) for value in proposals),
                        'authoredCadenceCount': len(cadences),
                        'declaredRankedProposalCount': sum(value['existingDevelopmentDeclaration'] is not None
                                                          for value in proposals),
                        'needsDefinitionProposalCount': sum(value['existingDevelopmentDeclaration'] is None
                                                           for value in proposals),
                        'outsideAssumedTargetWindowCount': sum(not transition['withinAssumedTargetWindow']
                            for value in proposals for transition in value['transitions'])},
            'proposals': proposals}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--drafts', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--minimum-rank-minutes', type=int, default=30)
    parser.add_argument('--target-rank-minutes', type=int, default=45)
    parser.add_argument('--maximum-rank-minutes', type=int, default=60)
    parser.add_argument('--common-use-interval-ms', type=int, default=5000)
    parser.add_argument('--cadences', type=Path)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    drafts = json.loads(args.drafts.read_text(encoding='utf-8'))
    verify_provenance(drafts, args.root.resolve(), args.dbc.resolve())
    cast_times, origin = load_cast_times(args.root.resolve(), args.dbc.resolve())
    cadences, cadence_origin = load_cadences(args.cadences, drafts)
    result = build_pacing(drafts, args.minimum_rank_minutes, args.target_rank_minutes,
                          args.maximum_rank_minutes, args.common_use_interval_ms, cast_times, origin,
                          cadences, cadence_origin, declared_profiles(args.root.resolve()))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
