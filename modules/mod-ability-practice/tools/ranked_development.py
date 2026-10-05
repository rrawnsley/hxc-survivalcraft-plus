import argparse
from collections import Counter
import json
from pathlib import Path

from profile_drafts import build_drafts, verify_provenance


def render_header(drafts):
    selected = [draft for draft in drafts if len(draft['ranks']) > 1 and draft['candidateOutcomeRoutes']]
    selected.sort(key=lambda draft: (draft['classId'], draft['abilityId']))
    classes = Counter(draft['classId'] for draft in selected)
    if set(classes) != set(range(12, 33)):
        raise ValueError('Expected ranked development coverage for all 21 custom classes')
    routes = {'damage': 'Damage', 'healing': 'Healing', 'interrupt': 'Interrupt',
              'dispel': 'Dispel', 'steal': 'Steal'}
    priority = tuple(routes)
    lines = ['// SPDX-License-Identifier: GPL-2.0-or-later', '',
             '#ifndef ABILITY_PRACTICE_DEVELOPMENT_RANKED_H', '#define ABILITY_PRACTICE_DEVELOPMENT_RANKED_H', '',
             '#include "AbilityPracticeDevelopment.h"', '#include "AbilityPracticeProfiles.h"', '',
             'namespace AbilityPractice::DevelopmentRanked', '{']
    profiles = []
    for draft in selected:
        class_id, ability_id = draft['classId'], draft['abilityId']
        name = 'Class' + str(class_id) + 'Ability' + str(ability_id)
        lines.append('inline constexpr std::array Ranks' + name + ' = {')
        for index, rank in enumerate(draft['ranks']):
            proficiency = 1 if index == 0 else 10 if index == 1 else (index - 1) * 20
            lines.append('    AbilityRank{ ' + str(rank['spellId']) + ', ' + str(rank['rankNumber']) + ', { ' +
                         str(rank['characterLevel']) + ', ' + str(proficiency) + ' } }' +
                         (',' if index + 1 < len(draft['ranks']) else ''))
        lines.extend(['};', 'inline constexpr auto Caps' + name + ' = Development::RankCaps(Ranks' + name + ');', ''])
        route = next((route for route in priority if route in draft['candidateOutcomeRoutes']), None)
        if route is None:
            raise ValueError('Unsupported candidate outcome')
        profiles.append(['    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,',
                         '        { ' + str(class_id) + ', ' + str(ability_id) + ', AbilityKind::Ranked, Ranks' +
                         name + ', Caps' + name + ' },',
                         '        Development::Policy, OutcomeKind::' + routes[route] + ' }'])
    lines.append('inline constexpr std::array Profiles = {')
    for index, profile in enumerate(profiles):
        lines.extend(profile[:-1] + [profile[-1] + (',' if index + 1 < len(profiles) else '')])
    lines.extend(['};', '}', '', '#endif', ''])
    return '\n'.join(lines), {'scope': 'unapproved-development-ranked-fixtures-not-production',
                             'profileCount': len(selected), 'classCount': len(classes),
                             'rankCount': sum(len(draft['ranks']) for draft in selected)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--candidates', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    candidates = json.loads(args.candidates.read_text(encoding='utf-8'))
    verify_provenance(candidates, args.root.resolve(), args.dbc.resolve())
    drafts = build_drafts(candidates)
    header, summary = render_header(drafts['drafts'])
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(header, encoding='utf-8', newline='\n')
    print(json.dumps(summary, sort_keys=True))


if __name__ == '__main__':
    main()
