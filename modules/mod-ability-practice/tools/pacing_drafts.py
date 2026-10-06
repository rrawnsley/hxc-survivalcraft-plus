import argparse
import hashlib
import json
import sys
from pathlib import Path

from coverage import declared_profiles, validate_rank_agreement
from profile_drafts import raw_channel_profile, verify_provenance


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



def load_durations(root, directory):
    sys.path.insert(0, str(root / 'apps/coa-dbc'))
    from inspect_dbc import DataSet
    dataset = DataSet(directory, root=root)
    table, schema, index, origin = dataset.load('SpellDuration')
    names = ('Duration', 'DurationPerLevel', 'MaxDuration')
    columns = {field.name: field for field in schema.columns}
    if any(name not in columns for name in names):
        raise ValueError('Reviewed duration schema is incomplete')
    values = {}
    for identity, row in index.items():
        record = {}
        for name in names:
            value, error = dataset.value(table, row, columns[name])
            if error or type(value) is not int or not -2147483648 <= value <= 2147483647:
                raise ValueError('Invalid raw duration: ' + str(identity))
            record[name] = value
        values[identity] = record
    return values, origin


def describe_channel_timing(profile, durations):
    channel = raw_channel_profile({'channelProfile': profile})
    duration_index = channel['durationIndex']
    duration = durations.get(duration_index) if channel['channeled'] and duration_index else None
    if channel['channeled'] and duration_index and duration is None:
        raise ValueError('Missing raw channel duration record: ' + str(duration_index))
    if not channel['channeled']:
        status = 'not-channeled'
    elif duration is None:
        status = 'no-duration-reference'
    elif duration['Duration'] == -1:
        status = 'unbounded-raw-duration'
    elif duration['Duration'] < 0:
        status = 'unsupported-negative-raw-duration'
    else:
        status = 'finite-raw-duration'
    constant_duration = duration['Duration'] if duration and duration['Duration'] >= 0 and (
        duration['DurationPerLevel'] == 0 and duration['MaxDuration'] == duration['Duration']) else None
    return {**channel, 'status': status,
            'rawBaseDurationMilliseconds': duration['Duration'] if duration else None,
            'rawDurationPerLevelMilliseconds': duration['DurationPerLevel'] if duration else None,
            'rawMaximumDurationMilliseconds': duration['MaxDuration'] if duration else None,
            'rawConstantChannelDurationMilliseconds': constant_duration,
            'durationIncludedInCurrentInterval': constant_duration is not None,
            'effectiveChannelDurationMeasured': False}


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
                 cast_times, cast_time_origin, cadences, cadence_origin, declarations, durations, duration_origin):
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
        if declaration and declaration['kind'] == 'fixed':
            validate_rank_agreement(draft, declaration)
            if identity in cadences:
                raise ValueError('Fixed utilities cannot use practice cadence overrides')
            continue
        if declaration and declaration['kind'] != 'ranked':
            raise ValueError('Pacing requires a ranked declared profile: ' + str(identity))
        validate_rank_agreement(draft, declaration)
        cadence = cadences.get(identity)
        cadence_interval = cadence['assumedUseIntervalMilliseconds'] if cadence else common_interval
        bands, transitions = [], []
        for index in range(1, len(ranks)):
            previous, upcoming = ranks[index - 1], ranks[index]
            channel = describe_channel_timing(previous.get('rawChannelProfile'), durations)
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
            channel_duration = channel['rawConstantChannelDurationMilliseconds']
            channel_floor = max(0, raw_cast_time) + channel_duration if channel_duration is not None else None
            interval = max(cadence_interval, timing['startRecoveryMilliseconds'], sequential_floor,
                           channel_floor if channel_floor is not None else 0)
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
                                'assumptionSource': ('maximum-cast-then-raw-recovery-constant-channel-occupancy-'
                                                     'global-or-authored-cadence-floor'),
                                'rawChannelTiming': channel,
                                'requiresChannelCadenceReview': channel['channeled'],
                                'castingTimeIndex': cast_index,
                                'rawBaseCastMilliseconds': raw_cast_time,
                                'rawRecoveryAfterCastMilliseconds': recovery,
                                'rawCastAndRecoveryFloorMilliseconds': sequential_floor,
                                'rawCastAndChannelFloorMilliseconds': channel_floor,
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
                                                    {'native-cooldown-and-channel-lifecycle'} |
                                                    ({'raw-channel-duration-and-cadence'} if any(
                                                        value['requiresChannelCadenceReview']
                                                        for value in transitions) else set())),
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
            'rawChannelInfoIncluded': True, 'rawConstantChannelDurationIncluded': True,
            'channelDurationIncluded': all(not transition['requiresChannelCadenceReview'] or
                transition['rawChannelTiming']['durationIncludedInCurrentInterval']
                for value in proposals for transition in value['transitions']),
            'effectiveChannelModifiersIncluded': False,
            'cooldownLifecycleExceptionsResolved': False,
            'measuredUseFrequency': False,
            'unrankedRewardsTuned': False, 'partialCreditScale': 30,
            'savedProgressMigrationExecutedByThisTool': False,
            'nativeVersionedConversionAvailable': True, 'sources': drafts['sources'],
            'nativeOutcomeSources': drafts['nativeOutcomeSources'], 'dbcOrigin': drafts['dbcOrigin'],
            'castTimeDbcOrigin': cast_time_origin, 'durationDbcOrigin': duration_origin,
            'authoredCadenceOrigin': cadence_origin,
            'summary': {'rankedProposalCount': len(proposals),
                        'transitionCount': sum(len(value['transitions']) for value in proposals),
                        'channeledTransitionCount': sum(transition['requiresChannelCadenceReview']
                            for value in proposals for transition in value['transitions']),
                        'unresolvedChannelTransitionCount': sum(transition['requiresChannelCadenceReview'] and
                            not transition['rawChannelTiming']['durationIncludedInCurrentInterval']
                            for value in proposals for transition in value['transitions']),
                        'declaredChanneledTransitionCount': sum(transition['requiresChannelCadenceReview']
                            for value in proposals if value['existingDevelopmentDeclaration']
                            for transition in value['transitions']),
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
    durations, duration_origin = load_durations(args.root.resolve(), args.dbc.resolve())
    cadences, cadence_origin = load_cadences(args.cadences, drafts)
    result = build_pacing(drafts, args.minimum_rank_minutes, args.target_rank_minutes,
                          args.maximum_rank_minutes, args.common_use_interval_ms, cast_times, origin,
                          cadences, cadence_origin, declared_profiles(args.root.resolve()), durations, duration_origin)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
