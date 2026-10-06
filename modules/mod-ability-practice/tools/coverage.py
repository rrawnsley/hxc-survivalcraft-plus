import argparse
from collections import Counter
import json
from pathlib import Path
import re

from profile_drafts import verify_provenance


PROFILE_HEADERS = ('AbilityPracticeDevelopmentRanked.h', 'AbilityPracticeDevelopmentPeriodic.h',
                   'AbilityPracticeDevelopmentMastery.h', 'AbilityPracticeDevelopmentHelpers.h',
                   'AbilityPracticeDevelopmentFixed.h', 'AbilityPracticeDevelopmentAbsorption.h',
                   'AbilityPracticeDevelopmentControl.h', 'AbilityPracticeDevelopmentTrainerFixed.h',
                   'AbilityPracticeDevelopmentLeech.h', 'AbilityPracticeDevelopmentConjureFixed.h',
                   'AbilityPracticeDevelopmentPassiveFixed.h', 'AbilityPracticeDevelopmentUtilityFixed.h',
                   'AbilityPracticeDevelopmentControlFixed.h', 'AbilityPracticeDevelopmentBuffs.h')
PROFILE_PATTERN = re.compile(
    r'AbilityProfile\s*\{\s*Development::DefinitionVersion,\s*AcquisitionSource::(?:ClassGrant|ClassTrainer),\s*'
    r'\{\s*(\d+),\s*(\d+),\s*AbilityKind::(Ranked|Mastery|Fixed)\s*,\s*([\w:]+)\s*,')


def declared_rank_arrays(root):
    result = {}
    rank_pattern = re.compile(r'AbilityRank\s*\{\s*(\d+),\s*(\d+),\s*'
                              r'\{\s*(\d+),\s*(\d+)\s*\}\s*\}')
    for filename in PROFILE_HEADERS:
        text = (root / 'modules/mod-ability-practice/src' / filename).read_text(encoding='utf-8')
        namespace = re.search(r'namespace\s+AbilityPractice::(\w+)\s*\{', text)
        if not namespace:
            raise ValueError('Missing development namespace: ' + filename)
        for match in re.finditer(r'inline\s+constexpr\s+std::array\s+(\w+)\s*=\s*\{(.*?)\};', text,
                                 re.DOTALL):
            body = match[2]
            ranks = list(rank_pattern.finditer(body))
            if not ranks:
                continue
            if rank_pattern.sub('', body).replace(',', '').strip():
                raise ValueError('Unsupported authored rank array: ' + filename + ':' + match[1])
            key = namespace[1] + '::' + match[1]
            if key in result:
                raise ValueError('Duplicate authored rank array: ' + key)
            result[key] = [{'spellId': int(rank[1]), 'rankNumber': int(rank[2]),
                            'characterLevel': int(rank[3]), 'proficiencyRequired': int(rank[4])} for rank in ranks]
    return result


def declared_profiles(root):
    arrays = declared_rank_arrays(root)
    result = {}
    for filename in PROFILE_HEADERS:
        relative = 'modules/mod-ability-practice/src/' + filename
        text = (root / relative).read_text(encoding='utf-8')
        namespace = re.search(r'namespace\s+AbilityPractice::(\w+)\s*\{', text)
        matches = list(PROFILE_PATTERN.finditer(text))
        if not matches or len(matches) != len(re.findall(r'\bAbilityProfile\s*\{', text)):
            raise ValueError('Unsupported profile declaration shape: ' + relative)
        for match in matches:
            identity = (int(match[1]), int(match[2]))
            kind = match[3].lower()
            acquisition = ('class-trainer-source-evidence' if 'AcquisitionSource::ClassTrainer' in match[0] else
                           'class-grant-source-evidence')
            reference = match[4] if '::' in match[4] else namespace[1] + '::' + match[4]
            if reference not in arrays:
                raise ValueError('Missing declared rank array: ' + reference)
            ranks = arrays[reference]
            if identity in result:
                existing = result[identity]
                if (existing['kind'] != kind or existing['authoredRanks'] != ranks
                        or existing['acquisitionSource'] != acquisition or relative in existing['sources']):
                    raise ValueError('Conflicting or repeated header declaration: ' + str(identity))
                existing['sources'].append(relative)
                existing['requiresRuntimeEquivalenceCheck'] = True
            else:
                result[identity] = {'kind': kind, 'sources': [relative], 'authoredRanks': ranks,
                                    'acquisitionSource': acquisition,
                                    'requiresRuntimeEquivalenceCheck': False}
    return result


def review_queues(draft):
    traits = draft.get('actionTraits')
    routes = draft.get('candidateOutcomeRoutes')
    periodic = draft.get('candidatePeriodicOutcomeRoutes', [])
    if not isinstance(traits, list) or not isinstance(routes, list) or not isinstance(periodic, list) or any(
            not isinstance(value, str) for value in traits + routes + periodic):
        raise ValueError('Invalid action traits or candidate routes')
    if len(set(periodic)) != len(periodic) or any(route not in {'damage', 'healing'} for route in periodic):
        raise ValueError('Invalid periodic candidate routes')
    mapping = {'passive-flag-review': 'passive-classification',
               'triggered-attribution-review': 'triggered-attribution',
               'pet-or-summon-ownership-review': 'pet-or-summon-ownership',
               'scripted-behavior-review': 'scripted-outcome',
               'periodic-attribution-review': 'periodic-attribution',
               'control-effect-attribution-review': 'control-effect-attribution-and-meaningful-use',
               'unknown-raw-aura-review': 'unknown-aura', 'unknown-raw-effect-review': 'unknown-effect'}
    queues = {mapping[trait] for trait in traits if trait in mapping}
    trigger_summary = draft.get('rawTriggerReferenceSummary', {})
    if trigger_summary.get('rootsWithDetectedCycles'):
        queues.add('cyclic-raw-trigger-reference-execution-review')
    if trigger_summary.get('incompleteRootSpellIds'):
        queues.add('incomplete-raw-trigger-reference-review')
    if draft['classId'] == 30 and draft['abilityId'] == 561289:
        queues.add('corpse-resource-and-post-combat-use-design')
    if draft['classId'] == 12 and draft['abilityId'] == 300857:
        queues.add('owned-buff-original-combat-cast-contribution')
    if len(draft['ranks']) == 1:
        queues.add('unranked-mastery-or-fixed-design')
    if set(routes) & {'interrupt', 'dispel', 'steal'}:
        queues.add('utility-classification-and-meaningful-use')
    if set(routes) & {'fear', 'stun', 'root'}:
        queues.add('control-effect-attribution-and-meaningful-use')
    if len(draft['ranks']) > 1 and set(routes) & {'damage', 'healing'}:
        queues.add('ranked-common-outcome')
    if periodic:
        queues.add('native-periodic-outcome-and-attribution')
    if any(rank.get('rawCastProfile') is None for rank in draft['ranks']):
        queues.add('missing-raw-action-timing')
    if not routes and not periodic:
        queues.add('missing-common-supported-outcome')
    return sorted(queues)


def validate_rank_agreement(draft, declaration):
    if declaration is None:
        return
    identity = (draft['classId'], draft['abilityId'])
    if declaration['acquisitionSource'] != draft['acquisitionSource']:
        raise ValueError('Declared acquisition and source evidence differ: ' + str(identity))
    authored = declaration['authoredRanks']
    source = [{key: rank[key] for key in ('spellId', 'rankNumber', 'characterLevel')}
              for rank in draft['ranks']]
    actual = [{key: rank[key] for key in ('spellId', 'rankNumber', 'characterLevel')} for rank in authored]
    if actual != source:
        raise ValueError('Declared ranks and source ladder differ: ' + str(identity))
    expected = ([1] * len(authored) if declaration['kind'] == 'fixed' else
                [1 if index == 0 else 10 if index == 1 else (index - 1) * 20
                 for index in range(len(authored))])
    if [rank['proficiencyRequired'] for rank in authored] != expected:
        raise ValueError('Unsupported authored proficiency ladder: ' + str(identity))


def build_coverage(drafts, declarations):
    if drafts.get('schemaVersion') != 1 or drafts.get('scope') != (
            'unapproved-definition-drafts-not-runtime-profiles') or drafts.get('productionApproved') is not False:
        raise ValueError('Expected unapproved source-consistent drafts')
    rows, seen = [], set()
    for draft in drafts['drafts']:
        identity = (draft['classId'], draft['abilityId'])
        if any(type(value) is not int or not 1 <= value <= 4294967295 for value in identity) or identity in seen:
            raise ValueError('Invalid or duplicate draft identity')
        if draft.get('productionApproved') is not False or draft.get('kind') is not None or not draft.get('ranks'):
            raise ValueError('Expected unapproved, unclassified source draft')
        seen.add(identity)
        declaration = declarations.get(identity)
        baseline = draft.get('nativeBaselineExclusion')
        if baseline and (declaration or identity[1] not in {
                75, 81, 107, 674, 2764, 3018, 3124, 5019, 6603, 28875, 536213, 552011, 632621} or
                         len(draft['ranks']) != 1):
            raise ValueError('Native baseline cannot be a development practice profile')
        if declaration and ((declaration['kind'] == 'ranked' and len(draft['ranks']) < 2) or
                            (declaration['kind'] == 'mastery' and len(draft['ranks']) != 1)):
            raise ValueError('Declared kind and source rank count differ: ' + str(identity))
        validate_rank_agreement(draft, declaration)
        rows.append({'classId': identity[0], 'abilityId': identity[1],
                     'nameFromRawDbc': draft['ranks'][0].get('nameFromRawDbc'),
                     'sourceRankCount': len(draft['ranks']), 'declaredDevelopmentProfile': declaration,
                     'nativeBaselineExclusion': baseline,
                     'rawCastProfiles': [{'spellId': rank['spellId'], **rank['rawCastProfile']}
                         for rank in draft['ranks'] if rank.get('rawCastProfile') is not None],
                     'rawChannelProfiles': [{'spellId': rank['spellId'], **rank['rawChannelProfile']}
                         for rank in draft['ranks']],
                     'candidateOutcomeRoutes': draft['candidateOutcomeRoutes'],
                     'candidatePeriodicOutcomeRoutes': draft.get('candidatePeriodicOutcomeRoutes', []),
                     'rawTriggerReferenceSummary': draft.get('rawTriggerReferenceSummary'),
                     'actionTraits': draft['actionTraits'], 'requiredReviews': draft['requiredReviews'],
                     'reviewFlags': draft['reviewFlags'],
                     'pendingReviewQueues': [] if declaration or baseline else review_queues(draft),
                     'qualificationReviewQueues': review_queues(draft),
                     'practiceDecision': ('excluded-native-passive-baseline' if identity[1] in {
                         28875, 536213, 552011, 632621} else
                                          'excluded-native-combat-baseline') if baseline else 'unreviewed',
                     'productionApproved': False, 'runtimeQualified': False})
    if set(declarations) - seen:
        raise ValueError('Declared profile absent from source-consistent drafts')
    rows.sort(key=lambda row: (row['classId'], row['abilityId']))
    classes = sorted({row['classId'] for row in rows})

    def summarize(selected):
        pending = [row for row in selected if not row['declaredDevelopmentProfile'] and
                   not row['nativeBaselineExclusion']]
        declared = [row for row in selected if row['declaredDevelopmentProfile']]
        kinds = Counter(row['declaredDevelopmentProfile']['kind'] for row in selected
                        if row['declaredDevelopmentProfile'])
        return {'sourceGroupCount': len(selected), 'declaredDevelopmentProfileCount': sum(kinds.values()),
                'profileDeclarationCount': sum(len(row['declaredDevelopmentProfile']['sources']) for row in selected
                                               if row['declaredDevelopmentProfile']),
                'sharedDeclarationProfileCount': sum(bool(row['declaredDevelopmentProfile'] and
                    row['declaredDevelopmentProfile']['requiresRuntimeEquivalenceCheck']) for row in selected),
                'declaredDevelopmentKinds': dict(sorted(kinds.items())), 'needsDefinitionCount': len(pending),
                'nativeBaselineExclusionCount': sum(bool(row['nativeBaselineExclusion']) for row in selected),
                'withCompleteRawChannelInfoCount': sum(len(row['rawChannelProfiles']) == row['sourceRankCount']
                                                        for row in selected),
                'needsDefinitionWithRawOutcomeCount': sum(bool(row['candidateOutcomeRoutes']) for row in pending),
                'needsDefinitionWithRawPeriodicOutcomeCount': sum(bool(row['candidatePeriodicOutcomeRoutes'])
                                                                for row in pending),
                'pendingRankedGroupCount': sum(row['sourceRankCount'] > 1 for row in pending),
                'pendingStandaloneGroupCount': sum(row['sourceRankCount'] == 1 for row in pending),
                'withCompleteRawTimingCount': sum(len(row['rawCastProfiles']) == row['sourceRankCount']
                                                  for row in selected),
                'unqualifiedSourceGroupCount': sum(row['runtimeQualified'] is False for row in selected),
                'declaredUnqualifiedProfileCount': sum(row['runtimeQualified'] is False for row in declared),
                'declaredSourceRankAgreementCount': len(declared),
                'declaredReviewQueueCounts': dict(sorted(Counter(queue for row in declared
                    for queue in row['qualificationReviewQueues']).items())),
                'qualificationReviewQueueCounts': dict(sorted(Counter(queue for row in selected
                    for queue in row['qualificationReviewQueues']).items())),
                'pendingReviewQueueCounts': dict(sorted(Counter(queue for row in pending
                    for queue in row['pendingReviewQueues']).items()))}

    return {'schemaVersion': 1, 'scope': 'source-declaration-coverage-not-runtime-or-production-approval',
            'mode': 'broad-ranked-with-all-optional-development-profiles',
            'productionApproved': False, 'runtimeQualified': False, 'summary': summarize(rows),
            'sources': drafts['sources'], 'nativeOutcomeSources': drafts['nativeOutcomeSources'],
            'dbcOrigin': drafts['dbcOrigin'],
            'classes': [{'classId': identity, **summarize([row for row in rows if row['classId'] == identity])}
                        for identity in classes], 'abilities': rows}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--drafts', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    root = args.root.resolve()
    drafts = json.loads(args.drafts.read_text(encoding='utf-8'))
    verify_provenance(drafts, root, args.dbc.resolve())
    result = build_coverage(drafts, declared_profiles(root))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
