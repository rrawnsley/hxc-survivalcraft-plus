import argparse
import json
from pathlib import Path
import re

from coverage import declared_profiles, validate_rank_agreement
from pacing_drafts import describe_channel_timing, load_cast_times, load_durations
from profile_drafts import verify_provenance


def arrays(text):
    result = {}
    for match in re.finditer(r'inline\s+constexpr\s+std::array\s+(\w+)\s*=\s*\{(.*?)\};', text, re.DOTALL):
        if match[1] in result:
            raise ValueError('Duplicate authored array')
        result[match[1]] = match[2]
    return result


def entries(body, pattern):
    matches = list(re.finditer(pattern, body))
    if not matches or re.sub(pattern, '', body).replace(',', '').strip():
        raise ValueError('Unsupported authored entry shape')
    values = [tuple(int(value) if value is not None else 0 for value in match.groups()) for match in matches]
    if any(not 0 <= number <= 4294967295 for value in values for number in value):
        raise ValueError('Invalid authored integer')
    return values


def authored_profiles(root):
    directory = root / 'modules/mod-ability-practice/src'
    base = (directory / 'AbilityPracticeDevelopment.h').read_text(encoding='utf-8')
    text = (directory / 'AbilityPracticeDevelopmentMastery.h').read_text(encoding='utf-8')
    version = re.search(r'\bDefinitionVersion\s*=\s*(\d+)\s*;', base)
    if not version or int(version[1]) < 1:
        raise ValueError('Missing development definition version')
    cap = re.search(r'inline\s+constexpr\s+auto\s+Caps\s*=\s*\[\]\s*\{\s*'
                    r'auto\s+result\s*=\s*Development::Caps;\s*'
                    r'for\s*\(ProficiencyCap&\s+cap\s*:\s*result\)\s*'
                    r'cap\.Proficiency\s*=\s*std::min\(cap\.Proficiency,\s*std::uint32_t\{\s*(\d+)\s*\}\);\s*'
                    r'return\s+result;\s*\}\(\);', text)
    if not cap or not 1 <= int(cap[1]) <= 4294967295 or not re.search(
            r'result\[index\]\s*=\s*\{\s*index\s*\+\s*1,\s*\(index\s*\+\s*1\)\s*\*\s*5\s*\}', base):
        raise ValueError('Unsupported mastery cap source shape')
    local, development = arrays(text), arrays(base)
    band_pattern = r'TrainingBand\s*\{\s*(\d+),\s*(\d+),\s*(\d+)\s*\}'
    reward_pattern = r'MasteryReward\s*\{\s*\{\s*(\d+),\s*(\d+)\s*\},\s*(\d+)(?:,\s*(\d+))?\s*\}'
    policies = {'Development::Policy': entries(development['Bands'], band_pattern)}
    for match in re.finditer(r'inline\s+constexpr\s+TrainingPolicy\s+(\w+)\s*\{\s*(\w+)\s*\};', text):
        if match[1] in policies or match[2] not in local:
            raise ValueError('Invalid authored policy reference')
        policies[match[1]] = entries(local[match[2]], band_pattern)
    pattern = (r'AbilityProfile\s*\{\s*Development::DefinitionVersion,\s*AcquisitionSource::ClassGrant,\s*'
               r'\{\s*(\d+),\s*(\d+),\s*AbilityKind::Mastery,\s*(\w+),\s*Caps\s*\},\s*'
               r'([\w:]+),\s*OutcomeKind::(Damage|Healing),\s*(\w+)\s*\}')
    matches = list(re.finditer(pattern, text))
    if len(matches) != len(re.findall(r'\bAbilityProfile\s*\{', text)):
        raise ValueError('Unsupported mastery profile shape')
    result = {}
    for match in matches:
        identity = (int(match[1]), int(match[2]))
        if identity in result or match[4] not in policies or match[6] not in local:
            raise ValueError('Invalid mastery profile references')
        bands, rewards = policies[match[4]], entries(local[match[6]], reward_pattern)
        if bands[0][0] != 1 or any(not cost or not rate for first, cost, rate in bands) or any(
                current[0] <= previous[0] for previous, current in zip(bands, bands[1:])):
            raise ValueError('Invalid mastery policy')
        result[identity] = {'definitionVersion': int(version[1]), 'outcome': match[5].lower(),
                            'maximumProficiency': int(cap[1]),
                            'policySource': match[4], 'bands': bands, 'rewards': rewards}
    return result


def baseline_uses(bands, start, target):
    proficiency, points, uses = start, 0, 0
    while proficiency < target:
        index = max(index for index, band in enumerate(bands) if band[0] <= proficiency)
        first, cost, rate = bands[index]
        end = min(target, bands[index + 1][0]) if index + 1 < len(bands) else target
        if points >= cost:
            levels = min(points // cost, end - proficiency)
            proficiency += levels
            points -= levels * cost
            continue
        remaining = (end - proficiency) * cost - points
        actions = (remaining + rate - 1) // rate
        uses += actions
        if uses > 18446744073709551615:
            raise ValueError('Mastery baseline exceeds native forecast bounds')
        points, proficiency = actions * rate - remaining, end
    return uses


def build_report(drafts, declarations, profiles, cast_times, durations, common_interval):
    expected = {identity for identity, value in declarations.items() if value['kind'] == 'mastery'}
    if set(profiles) != expected:
        raise ValueError('Mastery source and declared catalog differ')
    rows = []
    for draft in drafts['drafts']:
        identity = (draft['classId'], draft['abilityId'])
        if identity not in profiles:
            continue
        validate_rank_agreement(draft, declarations[identity])
        profile, rank = profiles[identity], draft['ranks'][0]
        if profile['outcome'] not in draft['candidateOutcomeRoutes']:
            raise ValueError('Mastery route lacks raw common outcome evidence')
        timing = rank['rawCastProfile']
        cast_index = timing['castingTimeIndex']
        if cast_index and cast_index not in cast_times:
            raise ValueError('Missing raw mastery cast duration')
        cast_time = cast_times.get(cast_index, 0)
        channel = describe_channel_timing(rank['rawChannelProfile'], durations)
        recovery = max(timing['recoveryMilliseconds'], timing['categoryRecoveryMilliseconds'])
        channel_duration = channel['rawConstantChannelDurationMilliseconds']
        interval = max(common_interval, timing['startRecoveryMilliseconds'], max(0, cast_time) + recovery,
                       max(0, cast_time) + channel_duration if channel_duration is not None else 0)
        milestones, proposed_bands = [], []
        previous_level, previous_proficiency, previous_bonus = rank['characterLevel'], 1, 0
        for level, proficiency, healing, damage in profile['rewards']:
            bonus = healing if profile['outcome'] == 'healing' else damage
            wrong_bonus = damage if profile['outcome'] == 'healing' else healing
            if not previous_level <= level <= 80 or not previous_proficiency < proficiency <= (
                    min(level * 5, profile['maximumProficiency'])) or (
                    wrong_bonus or not previous_bonus < bonus <= 200):
                raise ValueError('Invalid authored mastery reward')
            uses = baseline_uses(profile['bands'], previous_proficiency, proficiency)
            milliseconds = uses * interval
            proposed_uses = max(1, (2700000 + interval // 2) // interval)
            proposed_band = (previous_proficiency, proposed_uses * 30, (proficiency - previous_proficiency) * 30)
            if any(number > 4294967295 for number in proposed_band):
                raise ValueError('Proposed mastery policy exceeds native integer bounds')
            if not proposed_bands or proposed_bands[-1][1:] != proposed_band[1:]:
                proposed_bands.append(proposed_band)
            milestones.append({'characterLevel': level, 'proficiencyRequired': proficiency,
                               'healingBasisPoints': healing, 'damageBasisPoints': damage,
                               'baselineUsesFromPriorMilestoneAndZeroPartial': uses,
                               'estimatedBaselineCombatMilliseconds': milliseconds,
                               'withinAssumedTargetWindow': 1800000 <= milliseconds <= 3600000,
                               'proposedBaselineUsesFromPriorMilestoneAndZeroPartial': proposed_uses,
                               'proposedEstimatedBaselineCombatMilliseconds': proposed_uses * interval})
            previous_level, previous_proficiency, previous_bonus = level, proficiency, bonus
        rows.append({'classId': identity[0], 'abilityId': identity[1], 'nameFromRawDbc': rank['nameFromRawDbc'],
                     'authoredRanks': declarations[identity]['authoredRanks'],
                     'proposedBands': proposed_bands, 'changesCurrentPolicy': profile['bands'] != proposed_bands,
                     **profile, 'rawCastProfile': timing, 'rawChannelTiming': channel,
                     'rawBaseCastMilliseconds': cast_time, 'assumedUseIntervalMilliseconds': interval,
                     'milestones': milestones, 'runtimeQualified': False, 'productionApproved': False,
                     'futureTuningRequiresSavedProgressMigrationReview': True,
                     'requiredReviews': draft['requiredReviews'], 'reviewFlags': draft['reviewFlags']})
    if len(rows) != len(profiles):
        raise ValueError('Missing source mastery draft')
    return {'schemaVersion': 1, 'scope': 'authored-mastery-pacing-source-arithmetic-not-runtime-qualification',
            'productionApproved': False, 'runtimeQualified': False, 'includesCatchup': False,
            'measuredOrdinaryUseFrequency': False, 'assumedCommonUseIntervalMilliseconds': common_interval,
            'minimumMilestoneMinutes': 30, 'targetMilestoneMinutes': 45,
            'maximumMilestoneMinutes': 60, 'profiles': rows,
            'sources': drafts['sources'], 'nativeOutcomeSources': drafts['nativeOutcomeSources'],
            'dbcOrigin': drafts['dbcOrigin'],
            'summary': {'profileCount': len(rows), 'milestoneCount': sum(len(row['milestones']) for row in rows),
                        'outsideAssumedTargetWindowCount': sum(not milestone['withinAssumedTargetWindow']
                            for row in rows for milestone in row['milestones']),
                        'proposedPolicyChangeCount': sum(row['changesCurrentPolicy'] for row in rows),
                        'proposedOutsideAssumedTargetWindowCount': sum(not 1800000 <=
                            milestone['proposedEstimatedBaselineCombatMilliseconds'] <= 3600000
                            for row in rows for milestone in row['milestones'])}}


def render_native_header(report, version):
    if not 2 <= version <= 4294967295:
        raise ValueError('Mastery pacing requires a newer definition version')
    selected = sorted((row for row in report['profiles'] if row['changesCurrentPolicy']),
                      key=lambda row: (row['classId'], row['abilityId']))
    if not selected or any(row['definitionVersion'] != 1 for row in selected):
        raise ValueError('Mastery pacing requires reviewed version1 policies')
    lines = ['// SPDX-License-Identifier: GPL-2.0-or-later', '',
             '#ifndef ABILITY_PRACTICE_DEVELOPMENT_MASTERY_PACING_H',
             '#define ABILITY_PRACTICE_DEVELOPMENT_MASTERY_PACING_H', '',
             '#include "AbilityPracticeProfiles.h"', '', 'namespace AbilityPractice::DevelopmentMasteryPacing', '{',
             'inline constexpr std::uint32_t PreviousDefinitionVersion = 1;',
             'inline constexpr std::uint32_t DefinitionVersion = ' + str(version) + ';', '', 'struct Entry', '{',
             '    std::uint32_t ClassId;', '    std::uint32_t AbilityId;', '    OutcomeKind ExpectedOutcome;',
             '    std::span<AbilityRank const> ExpectedRanks;', '    std::span<MasteryReward const> ExpectedRewards;',
             '    TrainingPolicy PreviousPolicy;', '    TrainingPolicy Policy;', '};', '']
    names = []
    for row in selected:
        name = 'Class' + str(row['classId']) + 'Ability' + str(row['abilityId'])
        names.append((row, name))
        lines.append('inline constexpr std::array Ranks' + name + ' = {')
        for rank in row['authoredRanks']:
            lines.append('    AbilityRank{ ' + str(rank['spellId']) + ', ' + str(rank['rankNumber']) + ', { ' +
                         str(rank['characterLevel']) + ', ' + str(rank['proficiencyRequired']) + ' } }')
        lines.extend(['};', 'inline constexpr std::array Rewards' + name + ' = {'])
        for index, reward in enumerate(row['rewards']):
            level, proficiency, healing, damage = reward
            lines.append('    MasteryReward{ { ' + str(level) + ', ' + str(proficiency) + ' }, ' + str(healing) +
                         ', ' + str(damage) + ' }' + (',' if index + 1 < len(row['rewards']) else ''))
        lines.append('};')
        for prefix, bands in [('PreviousBands', row['bands']), ('Bands', row['proposedBands'])]:
            lines.append('inline constexpr std::array ' + prefix + name + ' = {')
            for index, band in enumerate(bands):
                lines.append('    TrainingBand{ ' + ', '.join(str(value) for value in band) + ' }' +
                             (',' if index + 1 < len(bands) else ''))
            lines.append('};')
        lines.append('')
    lines.append('inline constexpr std::array Entries = {')
    for index, (row, name) in enumerate(names):
        lines.extend(['    Entry{ ' + str(row['classId']) + ', ' + str(row['abilityId']) + ', OutcomeKind::' +
                      row['outcome'].capitalize() + ', Ranks' + name + ',',
                      '        Rewards' + name + ', { PreviousBands' + name + ' }, { Bands' + name + ' } }' +
                      (',' if index + 1 < len(names) else '')])
    lines.extend(['};', '}', '', '#endif', ''])
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--drafts', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--native-header', type=Path)
    parser.add_argument('--definition-version', type=int, default=2)
    parser.add_argument('--common-use-interval-ms', type=int, default=5000)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    root, dbc = args.root.resolve(), args.dbc.resolve()
    if not 1 <= args.common_use_interval_ms <= 86400000:
        raise ValueError('Invalid common mastery interval assumption')
    drafts = json.loads(args.drafts.read_text(encoding='utf-8'))
    verify_provenance(drafts, root, dbc)
    cast_times, cast_origin = load_cast_times(root, dbc)
    durations, duration_origin = load_durations(root, dbc)
    report = build_report(drafts, declared_profiles(root), authored_profiles(root), cast_times, durations,
                          args.common_use_interval_ms)
    report['castTimeOrigin'], report['durationOrigin'] = cast_origin, duration_origin
    if args.native_header:
        header = render_native_header(report, args.definition_version)
        if args.native_header.exists():
            previous = args.native_header.read_text(encoding='utf-8')
            version = re.search(r'(?<!Previous)DefinitionVersion\s*=\s*(\d+)\s*;', previous)
            if not version or (previous != header and args.definition_version <= int(version[1])):
                raise ValueError('Changed mastery pacing requires a strictly newer definition version')
        args.native_header.parent.mkdir(parents=True, exist_ok=True)
        args.native_header.write_text(header, encoding='utf-8', newline='\n')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True) + '\n', encoding='utf-8', newline='\n')
    print(json.dumps(report['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
