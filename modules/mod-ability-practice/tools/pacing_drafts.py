import argparse
import json
from pathlib import Path

from profile_drafts import verify_provenance


def build_pacing(drafts, minimum_minutes, target_minutes, maximum_minutes, common_interval):
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
            interval = max(common_interval, *intervals)
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
                                'assumptionSource': 'maximum-raw-recovery-or-common-cadence-floor',
                                'baselineUsesFromPriorThresholdAndZeroPartial': uses,
                                'estimatedBaselineCombatMilliseconds': milliseconds,
                                'withinAssumedTargetWindow': minimum_minutes * 60000 <= milliseconds <= (
                                    maximum_minutes * 60000),
                                'castingTimeIndexUnresolved': timing['castingTimeIndex']})
        proposals.append({'classId': identity[0], 'abilityId': identity[1],
                          'nameFromRawDbc': ranks[0]['nameFromRawDbc'], 'definitionVersion': None,
                          'productionApproved': False, 'runtimeQualified': False,
                          'requiresSavedProgressMigrationReview': True, 'proposedTrainingBands': bands,
                          'transitions': transitions, 'requiredReviews': draft['requiredReviews'],
                          'reviewFlags': draft['reviewFlags']})
    proposals.sort(key=lambda value: (value['classId'], value['abilityId']))
    return {'schemaVersion': 1, 'scope': 'unapproved-pacing-proposals-not-native-policy-or-measured-duration',
            'productionApproved': False, 'runtimeQualified': False,
            'minimumRankMinutes': minimum_minutes, 'targetRankMinutes': target_minutes,
            'maximumRankMinutes': maximum_minutes, 'assumedCommonUseIntervalMilliseconds': common_interval,
            'catchupIncluded': False, 'characterLevelWaitIncluded': False,
            'effectiveCooldownModifiersIncluded': False, 'measuredUseFrequency': False,
            'unrankedRewardsTuned': False, 'partialCreditScale': 30,
            'savedProgressMigrationImplemented': False, 'sources': drafts['sources'],
            'nativeOutcomeSources': drafts['nativeOutcomeSources'], 'dbcOrigin': drafts['dbcOrigin'],
            'summary': {'rankedProposalCount': len(proposals),
                        'transitionCount': sum(len(value['transitions']) for value in proposals),
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
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    drafts = json.loads(args.drafts.read_text(encoding='utf-8'))
    verify_provenance(drafts, args.root.resolve(), args.dbc.resolve())
    result = build_pacing(drafts, args.minimum_rank_minutes, args.target_rank_minutes,
                          args.maximum_rank_minutes, args.common_use_interval_ms)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
