import argparse
from collections import Counter
from copy import deepcopy
import hashlib
import json
from pathlib import Path
import re

from coverage import declared_profiles
from mastery_pacing_drafts import arrays, entries
from pacing_drafts import build_pacing, load_cadences, load_cast_times, load_durations
from profile_drafts import verify_provenance
from trainer_acquisition_review import (build_review, declared_rank_boundaries, rift_mappings, source_trainers)


def current_paced_profiles(root, declarations):
    path = root / 'modules/mod-ability-practice/src/AbilityPracticeDevelopmentPacing.h'
    text = path.read_text(encoding='utf-8')
    version = re.search(r'\bDefinitionVersion\s*=\s*(\d+)\s*;', text)
    previous = re.search(r'\bPreviousDefinitionVersion\s*=\s*(\d+)\s*;', text)
    if not version or not previous or (int(previous[1]), int(version[1])) != (1, 2):
        raise ValueError('Expected reviewed prior pacing versions1/2')
    bodies = arrays(text)
    band_pattern = r'TrainingBand\s*\{\s*(\d+),\s*(\d+),\s*(\d+)\s*\}'
    rank_pattern = (r'AbilityRank\s*\{\s*(\d+),\s*(\d+),\s*'
                    r'\{\s*(\d+),\s*(\d+)\s*\}\s*\}')
    if entries(bodies['PreviousBands'], band_pattern) != [(1, 30, 2), (20, 30, 1)]:
        raise ValueError('Prior definition1 policy changed')
    pattern = re.compile(r'Entry\s*\{\s*(\d+),\s*(\d+),\s*(\w+),\s*\{\s*(\w+)\s*\}\s*\}')
    matches = list(pattern.finditer(bodies['Entries']))
    if not matches or pattern.sub('', bodies['Entries']).replace(',', '').strip():
        raise ValueError('Unsupported paced declaration shape')
    result = {}
    for match in matches:
        identity = (int(match[1]), int(match[2]))
        if identity in result or identity not in declarations or declarations[identity]['kind'] != 'ranked':
            raise ValueError('Invalid paced profile identity')
        ranks = entries(bodies[match[3]], rank_pattern)
        authored = [tuple(rank[key] for key in ('spellId', 'rankNumber', 'characterLevel', 'proficiencyRequired'))
                    for rank in declarations[identity]['authoredRanks']]
        if ranks != authored:
            raise ValueError('Current paced ranks and declaration differ')
        bands = entries(bodies[match[4]], band_pattern)
        if len(bands) != len(ranks) - 1 or any(not cost or not rate for first, cost, rate in bands):
            raise ValueError('Invalid prior paced policy')
        result[identity] = [{'firstProficiency': first, 'pointsPerLevel': cost, 'pointsPerUse': rate}
                            for first, cost, rate in bands]
    if set(result) != {identity for identity, value in declarations.items() if value['kind'] == 'ranked'}:
        raise ValueError('Incomplete prior pacing coverage')
    return result


def projected_extensions(drafts, review, declarations, candidates):
    members = {(candidate['classId'], member['spellId']): member
               for candidate in candidates['candidates'] for member in candidate['members']}
    ladders = {(row['classId'], row['firstObservedSpellId']): row for row in review['rankLadders']}
    projected, projected_declarations, rows = deepcopy(drafts), deepcopy(declarations), []
    indexed = {(row['classId'], row['abilityId']): row for row in projected['drafts']}
    for boundary in review['practiceProfileTrainerRankBoundaries']:
        identity = (boundary['classId'], boundary['abilityId'])
        ladder, declaration = ladders[identity], declarations[identity]
        authored, flags = declaration['authoredRanks'], set(ladder['blockingFlags'])
        if declaration['kind'] != 'ranked' or not ladder['hasSourceConsistentClassGrantRoot']:
            flags.add('missing-reviewed-native-class-grant-prefix')
        source_prefix = [{key: rank[key] for key in ('spellId', 'rankNumber', 'characterLevel')}
                         for rank in ladder['ranks'][:len(authored)]]
        native_prefix = [{key: rank[key] for key in ('spellId', 'rankNumber', 'characterLevel')}
                         for rank in authored]
        if source_prefix != native_prefix:
            flags.add('source-trainer-and-native-prefix-disagree')
        full = []
        for index, rank in enumerate(ladder['ranks']):
            offers = rank['sourceTrainerOffers']
            earlier = {value['spellId'] for value in ladder['ranks'][:index]}
            if (len(offers) != 1 or offers[0]['requiredSkillLine'] or offers[0]['requiredSkillRank'] or
                    (not index and offers[0]['requiredAbilities']) or
                    (index and (not offers[0]['requiredAbilities'] or
                                not set(offers[0]['requiredAbilities']).issubset(earlier)))):
                flags.add('trainer-prerequisite-gate-needs-native-support')
            raw = members[(identity[0], rank['spellId'])].get('rawDbc', {})
            if (raw.get('passive') is not False or raw.get('fieldErrors') or
                    raw.get('name') != ladder['name'] or raw.get('rankLabel') != 'Rank ' + str(index + 1)):
                flags.add('raw-ranked-identity-or-active-evidence-changed')
            if type(rank['characterLevel']) is not int or not 1 <= rank['characterLevel'] <= 80:
                flags.add('unsupported-native-character-level')
            proficiency = 1 if not index else 10 if index == 1 else (index - 1) * 20
            full.append({'spellId': rank['spellId'], 'rankNumber': index + 1,
                         'characterLevel': rank['characterLevel'], 'proficiencyRequired': proficiency,
                         'acquisitionEvidence': 'native-class-grant-prefix' if index < len(authored) else
                                                'captured-and-source-class-trainer-extension',
                         'sourceTrainerOffers': offers, 'nameFromRawDbc': raw.get('name'),
                         'rawCastProfile': raw.get('castProfile'), 'rawChannelProfile': raw.get('channelProfile')})
        rows.append({'classId': identity[0], 'abilityId': identity[1], 'name': ladder['name'],
                     'status': 'blocked-by-source-evidence' if flags else 'needs-native-extension-and-migration',
                     'blockingFlags': sorted(flags), 'priorNativeDeclaration': declaration,
                     'projectedDefinitionVersion': 3, 'readablePriorDefinitionVersionsRequired': [1, 2],
                     'projectedRanks': full, 'addedRankCount': len(full) - len(authored),
                     'runtimeQualified': False, 'productionApproved': False})
        if flags:
            continue
        projected_declarations[identity]['acquisitionSource'] = 'class-grant-and-trainer-source-evidence'
        projected_declarations[identity]['authoredRanks'] = [
            {key: rank[key] for key in ('spellId', 'rankNumber', 'characterLevel', 'proficiencyRequired')}
            for rank in full]
        indexed[identity]['acquisitionSource'] = 'class-grant-and-trainer-source-evidence'
        indexed[identity]['ranks'] = full
    return projected, projected_declarations, rows


def declared_outcome(root, row):
    pattern = (r'AbilityProfile\s*\{\s*Development::DefinitionVersion,\s*AcquisitionSource::ClassGrant,\s*'
               r'\{\s*' + str(row['classId']) + r',\s*' + str(row['abilityId']) +
               r',\s*AbilityKind::Ranked,\s*[\w:]+,\s*[\w:]+\s*\},\s*'
               r'Development::Policy,\s*OutcomeKind::(\w+)\s*\}')
    outcomes = set()
    for source in row['priorNativeDeclaration']['sources']:
        matches = re.findall(pattern, (root / source).read_text(encoding='utf-8'))
        if len(matches) != 1:
            raise ValueError('Unsupported prior native outcome shape')
        outcomes.update(matches)
    if len(outcomes) != 1 or not outcomes.issubset({'Damage', 'Healing', 'Fear'}):
        raise ValueError('Conflicting or unsupported prior outcome')
    return next(iter(outcomes))


STAT_BUFF_IDENTITIES = {(22, 801523), (26, 573343)}
SPELL_POWER_BUFF_IDENTITIES = {(27, 575040)}


def render_native_header(root, rows, buff=False, stat=False, power=False, retained=None):
    if sum((buff, stat, power)) > 1:
        raise ValueError('Conflicting native extension scopes')
    expected = {(13, 807037), (16, 707044), (19, 801165), (26, 575039),
                (28, 802684), (29, 803198), (30, 800174), (31, 803981)}
    if buff:
        expected = {(12, 300857)}
    if stat:
        expected = STAT_BUFF_IDENTITIES
    if power:
        expected = SPELL_POWER_BUFF_IDENTITIES
    if retained is not None:
        if not retained or not retained.issubset(expected):
            raise ValueError('Unsupported retained native extension identities')
        expected = retained
    if (len(rows) != len(expected) or {(row['classId'], row['abilityId']) for row in rows} != expected or
            any(row['blockingFlags'] or not row.get('priorPacingPreserved') for row in rows)):
        raise ValueError('Native extension scope differs from explicitly reviewed complete projections')
    lines = ['// SPDX-License-Identifier: GPL-2.0-or-later', '',
             '#ifndef ABILITY_PRACTICE_DEVELOPMENT_TRAINER_RANKS_H',
             '#define ABILITY_PRACTICE_DEVELOPMENT_TRAINER_RANKS_H', '',
             '#include "AbilityPracticeDevelopment.h"', '#include "AbilityPracticeProfiles.h"', '',
             'namespace AbilityPractice::DevelopmentTrainerRanks', '{',
             'inline constexpr std::uint32_t DefinitionVersion = 3;', '',
             'struct TrainerRank', '{', '    std::uint32_t SpellId;', '    std::uint32_t CharacterLevel;',
             '    std::uint32_t TrainerId;', '    std::array<std::uint32_t, 3> RequiredAbilities;', '};', '',
             'struct Entry', '{', '    AbilityProfile Profile;', '    std::span<AbilityRank const> PreviousRanks;',
             '    std::span<ProficiencyCap const> PreviousCaps;', '    TrainingPolicy PreviousPolicy;',
             '    std::span<TrainerRank const> AdditionalTrainerRanks;', '};', '']
    if buff or stat or power:
        guard = 'SPELL_POWER_BUFF' if power else 'STAT_BUFF' if stat else 'BUFF'
        namespace = ('DevelopmentSpellPowerBuffTrainerRanks' if power else
                     'DevelopmentStatBuffTrainerRanks' if stat else 'DevelopmentBuffTrainerRanks')
        lines = ['// SPDX-License-Identifier: GPL-2.0-or-later', '',
                 '#ifndef ABILITY_PRACTICE_DEVELOPMENT_' + guard + '_TRAINER_RANKS_H',
                 '#define ABILITY_PRACTICE_DEVELOPMENT_' + guard + '_TRAINER_RANKS_H', '',
                 '#include "AbilityPracticeDevelopmentTrainerRanks.h"', '',
                 'namespace AbilityPractice::' + namespace, '{',
                 'inline constexpr std::uint32_t DefinitionVersion = 3;', '',
                 'using TrainerRank = DevelopmentTrainerRanks::TrainerRank;',
                 'using Entry = DevelopmentTrainerRanks::Entry;', '']
    rendered = []
    for row in rows:
        name = 'Class' + str(row['classId']) + 'Ability' + str(row['abilityId'])
        prior = row['priorNativeDeclaration']['authoredRanks']
        for prefix, ranks in [('PreviousRanks', prior), ('Ranks', row['projectedRanks'])]:
            lines.append('inline constexpr std::array ' + prefix + name + ' = {')
            for index, rank in enumerate(ranks):
                fields = [rank[key] for key in ('spellId', 'rankNumber', 'characterLevel', 'proficiencyRequired')]
                lines.append('    AbilityRank{ ' + str(fields[0]) + ', ' + str(fields[1]) + ', { ' +
                             str(fields[2]) + ', ' + str(fields[3]) + ' } }' +
                             (',' if index + 1 < len(ranks) else ''))
            lines.extend(['};', ''])
        for prefix, bands in [('PreviousBands', row['priorVersion2TrainingBands']),
                              ('Bands', row['projectedTrainingBands'])]:
            lines.append('inline constexpr std::array ' + prefix + name + ' = {')
            for index, band in enumerate(bands):
                fields = [band[key] for key in ('firstProficiency', 'pointsPerLevel', 'pointsPerUse')]
                lines.append('    TrainingBand{ ' + ', '.join(map(str, fields)) + ' }' +
                             (',' if index + 1 < len(bands) else ''))
            lines.extend(['};', ''])
        lines.extend(['inline constexpr auto PreviousCaps' + name + ' = Development::RankCaps(PreviousRanks' +
                      name + ');', 'inline constexpr auto Caps' + name + ' = Development::RankCaps(Ranks' + name + ');',
                      'inline constexpr std::array TrainerRanks' + name + ' = {'])
        added = row['projectedRanks'][len(prior):]
        for index, rank in enumerate(added):
            offer = rank['sourceTrainerOffers'][0]
            prerequisites = offer['requiredAbilities'] + [0] * (3 - len(offer['requiredAbilities']))
            lines.append('    TrainerRank{ ' + str(rank['spellId']) + ', ' + str(rank['characterLevel']) + ', ' +
                         str(offer['trainerId']) + ', { ' + ', '.join(map(str, prerequisites)) + ' } }' +
                         (',' if index + 1 < len(added) else ''))
        lines.extend(['};', ''])
        rendered.append(['    Entry{', '        { DefinitionVersion, AcquisitionSource::ClassGrant,',
                         '            { ' + str(row['classId']) + ', ' + str(row['abilityId']) +
                         ', AbilityKind::Ranked, Ranks' + name + ', Caps' + name + ' },',
                         '            { Bands' + name + ' }, OutcomeKind::' + declared_outcome(root, row) + ' },',
                         '        PreviousRanks' + name + ', PreviousCaps' + name + ',',
                         '        { PreviousBands' + name + ' }, TrainerRanks' + name, '    }'])
    lines.append('inline constexpr std::array Entries = {')
    for index, entry in enumerate(rendered):
        lines.extend(entry[:-1] + [entry[-1] + (',' if index + 1 < len(rendered) else '')])
    lines.extend(['};', '}', '', '#endif', ''])
    if any(len(line) > 120 for line in lines):
        raise ValueError('Generated native extension line exceeds120 columns')
    return '\n'.join(lines)


def preserves_existing_definitions(root, path, rows, buff, stat, power):
    original = path.read_bytes()
    pattern = r'\{\s*(\d+),\s*(\d+),\s*AbilityKind::Ranked,'
    identities = [(int(match[1]), int(match[2])) for match in re.finditer(pattern, original.decode('utf-8'))]
    previous = set(identities)
    current = {(row['classId'], row['abilityId']) for row in rows}
    if len(identities) != len(previous) or not previous or not previous < current:
        raise ValueError('Native extension additions must preserve a nonempty strict identity subset')
    retained = [row for row in rows if (row['classId'], row['abilityId']) in previous]
    if render_native_header(root, retained, buff, stat, power, previous).encode('utf-8') != original:
        raise ValueError('Native extension addition would change a frozen existing definition')
    return len(current - previous)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    parser.add_argument('--candidates', type=Path, required=True)
    parser.add_argument('--drafts', type=Path, required=True)
    parser.add_argument('--trainer-review', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--native-header', type=Path)
    parser.add_argument('--buff-native-header', type=Path)
    parser.add_argument('--stat-buff-native-header', type=Path)
    parser.add_argument('--spell-power-buff-native-header', type=Path)
    parser.add_argument('--allow-profile-additions', action='store_true')
    args = parser.parse_args()
    root, dbc = args.root.resolve(), args.dbc.resolve()
    candidates = json.loads(args.candidates.read_text(encoding='utf-8'))
    drafts = json.loads(args.drafts.read_text(encoding='utf-8'))
    review = json.loads(args.trainer_review.read_text(encoding='utf-8'))
    verify_provenance(candidates, root, dbc)
    verify_provenance(drafts, root, dbc)
    if (review.get('scope') != 'supplemental-trainer-source-review-not-native-entitlement' or
            review.get('inputSha256') != hashlib.sha256(args.candidates.read_bytes()).hexdigest()):
        raise ValueError('Unsupported or stale trainer review')
    declarations = declared_profiles(root)
    owners, offers = source_trainers(root)
    actual = build_review(candidates, owners, offers, rift_mappings(root))
    if (actual['rankLadders'] != review['rankLadders'] or
            declared_rank_boundaries(actual, declarations) != review['practiceProfileTrainerRankBoundaries']):
        raise ValueError('Trainer review differs from actual source and declarations')
    prior = current_paced_profiles(root, declarations)
    projected, projected_declarations, rows = projected_extensions(drafts, review, declarations, candidates)
    cast_times, cast_origin = load_cast_times(root, dbc)
    durations, duration_origin = load_durations(root, dbc)
    cadences, cadence_origin = load_cadences(root / 'modules/mod-ability-practice/tools/development-cadences.json',
                                           projected)
    pacing = build_pacing(projected, 30, 45, 60, 5000, cast_times, cast_origin, cadences, cadence_origin,
                          projected_declarations, durations, duration_origin)
    proposals = {(row['classId'], row['abilityId']): row for row in pacing['proposals']}
    for row in rows:
        if row['blockingFlags']:
            continue
        identity = (row['classId'], row['abilityId'])
        proposal = proposals[identity]
        bands = proposal['proposedTrainingBands']
        if bands[:len(prior[identity])] != prior[identity]:
            raise ValueError('Extension would retune prior version2 pacing: ' + str(identity))
        row['priorVersion2TrainingBands'] = prior[identity]
        row['projectedTrainingBands'] = bands
        row['priorPacingPreserved'] = True
        row['addedTransitions'] = proposal['transitions'][len(prior[identity]):]
        row['oneRankAheadCapProjection'] = proposal['oneRankAheadCapProjection']
        row['requiredNativeWork'] = ['mixed-class-grant-and-trainer-acquisition', 'loaded-full-rank-boundary',
                                    'explicit-version1-and2-readable-migration', 'preserve-whole-and-partial-progress',
                                    'retain-existing-learned-higher-ranks', 'unknown-version-preservation',
                                    'exact-source-trainer-prerequisite-evaluation',
                                    'effective-outcome-and-menu-gameplay-qualification']
    result = {'schemaVersion': 1, 'scope': 'unapproved-trainer-rank-extension-projections-not-runtime-definitions',
              'runtimeQualified': False, 'productionApproved': False, 'nativeHeaderGenerated': False,
              'savedProgressMigrationExecuted': False, 'measuredUseFrequency': False,
              'sources': candidates['sources'], 'nativeOutcomeSources': candidates['nativeOutcomeSources'],
              'dbcOrigin': candidates['dbcOrigin'], 'castTimeOrigin': cast_origin, 'durationOrigin': duration_origin,
              'cadenceOrigin': cadence_origin,
              'inputSha256': {'candidates': hashlib.sha256(args.candidates.read_bytes()).hexdigest(),
                              'drafts': hashlib.sha256(args.drafts.read_bytes()).hexdigest(),
                              'trainerReview': hashlib.sha256(args.trainer_review.read_bytes()).hexdigest()},
              'extensions': rows,
              'summary': {'profileCount': len(rows), 'addedRankCount': sum(row['addedRankCount'] for row in rows),
                          'statuses': dict(Counter(row['status'] for row in rows)),
                          'priorPacingPreservedCount': sum(row.get('priorPacingPreserved') is True for row in rows)}}
    for path, buff, stat, power in [(args.native_header, False, False, False),
                                    (args.buff_native_header, True, False, False),
                                    (args.stat_buff_native_header, False, True, False),
                                    (args.spell_power_buff_native_header, False, False, True)]:
        if not path:
            continue
        selected = [row for row in rows if ((row['classId'], row['abilityId']) == (12, 300857)) == buff and
                    ((row['classId'], row['abilityId']) in STAT_BUFF_IDENTITIES) == stat and
                    ((row['classId'], row['abilityId']) in SPELL_POWER_BUFF_IDENTITIES) == power]
        header = render_native_header(root, selected, buff, stat, power)
        path.parent.mkdir(parents=True, exist_ok=True)
        encoded = header.encode('utf-8')
        exists = path.exists()
        added = 0
        if exists and path.read_bytes() != encoded:
            if not args.allow_profile_additions:
                raise ValueError('Existing native definition3 differs; author a new definition version explicitly')
            added = preserves_existing_definitions(root, path, selected, buff, stat, power)
        if not exists or added:
            path.write_bytes(encoded)
        prefix = ('spellPowerBuffNativeHeader' if power else 'statBuffNativeHeader' if stat else
                  'buffNativeHeader' if buff else 'nativeHeader')
        result['nativeHeaderGenerated'] = True
        result[prefix + 'Updated'] = not exists or bool(added)
        result[prefix + 'AddedProfileCount'] = added
        result[prefix] = {'path': str(path.resolve()), 'sha256': hashlib.sha256(encoded).hexdigest()}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
