import argparse
import json
from pathlib import Path
import re

from coverage import declared_profiles
from pacing_drafts import build_pacing, load_cadences, load_cast_times, load_durations
from profile_drafts import verify_provenance


def render_header(proposals, root, next_version, expected_profile_count=118):
    if type(next_version) is not int or not 2 <= next_version <= 4294967295:
        raise ValueError('Invalid next development definition version')
    text = (root / 'modules/mod-ability-practice/src/AbilityPracticeDevelopment.h').read_text(encoding='utf-8')
    version = re.search(r'DefinitionVersion\s*=\s*(\d+)\s*;', text)
    bands = re.search(r'std::array\s+Bands\s*=\s*\{(.*?)\};', text, re.DOTALL)
    if not version or not bands or int(version[1]) != 1:
        raise ValueError('Expected reviewed prototype version1')
    pattern = re.compile(r'TrainingBand\s*\{\s*(\d+),\s*(\d+),\s*(\d+)\s*\}')
    previous = [tuple(map(int, match.groups())) for match in pattern.finditer(bands[1])]
    if previous != [(1, 30, 2), (20, 30, 1)] or pattern.sub('', bands[1]).replace(',', '').strip():
        raise ValueError('Prototype rates differ from reviewed migration source')
    selected = [value for value in proposals['proposals'] if value['existingDevelopmentDeclaration']]
    if (type(expected_profile_count) is not int or expected_profile_count < 118 or
            len(selected) != expected_profile_count or
            {value['classId'] for value in selected} != set(range(12, 33))):
        raise ValueError('Expected reviewed development rank declarations across21 classes')
    lines = ['// SPDX-License-Identifier: GPL-2.0-or-later', '',
             '#ifndef ABILITY_PRACTICE_DEVELOPMENT_PACING_H', '#define ABILITY_PRACTICE_DEVELOPMENT_PACING_H', '',
             '#include "AbilityPracticeProfiles.h"', '', 'namespace AbilityPractice::DevelopmentPacing', '{',
             'inline constexpr std::uint32_t PreviousDefinitionVersion = 1;',
             'inline constexpr std::uint32_t DefinitionVersion = ' + str(next_version) + ';',
             'inline constexpr std::array PreviousBands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };',
             'inline constexpr TrainingPolicy PreviousPolicy{ PreviousBands };', '', 'struct Entry', '{',
             '    std::uint32_t ClassId;', '    std::uint32_t AbilityId;',
             '    std::span<AbilityRank const> ExpectedRanks;', '    TrainingPolicy Policy;', '};', '']
    entries = []
    for value in selected:
        class_id, ability_id = value['classId'], value['abilityId']
        name = 'Class' + str(class_id) + 'Ability' + str(ability_id)
        ranks = value['existingDevelopmentDeclaration']['authoredRanks']
        policy = value['proposedTrainingBands']
        if len(policy) != len(ranks) - 1 or len(policy) > 64:
            raise ValueError('Invalid pacing band count')
        lines.append('inline constexpr std::array Ranks' + name + ' = {')
        for index, rank in enumerate(ranks):
            lines.append('    AbilityRank{ ' + str(rank['spellId']) + ', ' + str(rank['rankNumber']) + ', { ' +
                         str(rank['characterLevel']) + ', ' + str(rank['proficiencyRequired']) + ' } }' +
                         (',' if index + 1 < len(ranks) else ''))
        lines.extend(['};', 'inline constexpr std::array Bands' + name + ' = {'])
        for index, band in enumerate(policy):
            fields = [band[key] for key in ('firstProficiency', 'pointsPerLevel', 'pointsPerUse')]
            if any(type(number) is not int or not 1 <= number <= 4294967295 for number in fields) or (
                    fields[1] % 30):
                raise ValueError('Invalid or incompatible pacing band')
            lines.append('    TrainingBand{ ' + ', '.join(map(str, fields)) + ' }' +
                         (',' if index + 1 < len(policy) else ''))
        lines.extend(['};', ''])
        entries.append('    Entry{ ' + str(class_id) + ', ' + str(ability_id) + ', Ranks' + name +
                       ', { Bands' + name + ' } }')
    lines.append('inline constexpr std::array Entries = {')
    lines.extend(entry + (',' if index + 1 < len(entries) else '') for index, entry in enumerate(entries))
    lines.extend(['};', '}', '', '#endif', ''])
    return '\n'.join(lines), {'scope': 'unapproved-isolated-rank-pacing-not-production',
                              'profileCount': len(selected), 'definitionVersion': next_version,
                              'previousDefinitionVersion': 1, 'measuredUseFrequency': False}


def validate_profile_additions(proposals, root, definition_version, previous_header):
    pattern = re.compile(r'    Entry\{ (\d+), (\d+), RanksClass\1Ability\2, '
                         r'\{ BandsClass\1Ability\2 \} \}')
    matches = list(pattern.finditer(previous_header))
    previous_ids = {(int(match[1]), int(match[2])) for match in matches}
    if (len(previous_ids) < 118 or len(previous_ids) != len(matches) or
            len(matches) != len(re.findall(r'\bEntry\{', previous_header))):
        raise ValueError('Unsupported existing pacing entries for additive expansion')
    next_ids = {(value['classId'], value['abilityId']) for value in proposals['proposals']
                if value['existingDevelopmentDeclaration']}
    if not previous_ids < next_ids:
        raise ValueError('Additive expansion requires new profiles and retains every existing profile')
    previous_proposals = {**proposals, 'proposals': [value for value in proposals['proposals']
        if (value['classId'], value['abilityId']) in previous_ids]}
    reproduced, _ = render_header(previous_proposals, root, definition_version, len(previous_ids))
    if reproduced != previous_header:
        raise ValueError('Additive expansion cannot change existing ranks, rates, versions or header structure')
    return len(next_ids - previous_ids)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--drafts', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--cadences', type=Path)
    parser.add_argument('--definition-version', type=int, default=2)
    parser.add_argument('--allow-profile-additions', action='store_true')
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    root, dbc = args.root.resolve(), args.dbc.resolve()
    drafts = json.loads(args.drafts.read_text(encoding='utf-8'))
    verify_provenance(drafts, root, dbc)
    cast_times, origin = load_cast_times(root, dbc)
    durations, duration_origin = load_durations(root, dbc)
    cadence_path = args.cadences or root / 'modules/mod-ability-practice/tools/development-cadences.json'
    cadences, cadence_origin = load_cadences(cadence_path, drafts)
    proposals = build_pacing(drafts, 30, 45, 60, 5000, cast_times, origin,
                             cadences, cadence_origin, declared_profiles(root), durations, duration_origin)
    declared = {(value['classId'], value['abilityId']) for value in proposals['proposals']
                if value['existingDevelopmentDeclaration']}
    if set(cadences) - declared:
        raise ValueError('Native pacing cannot consume cadence assumptions for undeclared abilities')
    previous_header = args.output.read_text(encoding='utf-8') if args.output.exists() else None
    previous_version = re.search(r'(?<!Previous)DefinitionVersion\s*=\s*(\d+)\s*;', previous_header) \
        if previous_header is not None else None
    if previous_header is not None and not previous_version:
        raise ValueError('Refusing to replace an unknown output file')
    if args.allow_profile_additions and previous_header is None:
        raise ValueError('Additive expansion requires an existing reviewed pacing header')
    if args.allow_profile_additions and args.definition_version != int(previous_version[1]):
        raise ValueError('Additive expansion preserves the existing definition version')
    previous_count = len(re.findall(r'\bEntry\{', previous_header)) if previous_header is not None else 118
    expected_count = len(declared) if args.allow_profile_additions else previous_count
    header, summary = render_header(proposals, root, args.definition_version, expected_count)
    summary['addedProfileCount'] = 0
    if previous_header is not None and header != previous_header:
        if args.allow_profile_additions:
            summary['addedProfileCount'] = validate_profile_additions(
                proposals, root, args.definition_version, previous_header)
        elif args.definition_version <= int(previous_version[1]):
            raise ValueError('Changed native pacing requires a strictly newer definition version')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(header, encoding='utf-8', newline='\n')
    print(json.dumps(summary, sort_keys=True))


if __name__ == '__main__':
    main()
