import argparse
from collections import Counter
import json
from pathlib import Path
import re

from profile_drafts import verify_provenance


PROFILE_HEADERS = ('AbilityPracticeDevelopmentRanked.h', 'AbilityPracticeDevelopmentPeriodic.h',
                   'AbilityPracticeDevelopmentMastery.h', 'AbilityPracticeDevelopmentHelpers.h',
                   'AbilityPracticeDevelopmentFixed.h')
PROFILE_PATTERN = re.compile(
    r'AbilityProfile\s*\{\s*Development::DefinitionVersion,\s*AcquisitionSource::ClassGrant,\s*'
    r'\{\s*(\d+),\s*(\d+),\s*AbilityKind::(Ranked|Mastery|Fixed)\b')


def declared_profiles(root):
    result = {}
    for filename in PROFILE_HEADERS:
        relative = 'modules/mod-ability-practice/src/' + filename
        text = (root / relative).read_text(encoding='utf-8')
        matches = list(PROFILE_PATTERN.finditer(text))
        if not matches or len(matches) != len(re.findall(r'\bAbilityProfile\s*\{', text)):
            raise ValueError('Unsupported profile declaration shape: ' + relative)
        for match in matches:
            identity = (int(match[1]), int(match[2]))
            kind = match[3].lower()
            if identity in result:
                existing = result[identity]
                if existing['kind'] != kind or relative in existing['sources']:
                    raise ValueError('Conflicting or repeated header declaration: ' + str(identity))
                existing['sources'].append(relative)
                existing['requiresRuntimeEquivalenceCheck'] = True
            else:
                result[identity] = {'kind': kind, 'sources': [relative], 'requiresRuntimeEquivalenceCheck': False}
    return result


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
        if declaration and ((declaration['kind'] == 'ranked') != (len(draft['ranks']) > 1)):
            raise ValueError('Declared kind and source rank count differ: ' + str(identity))
        rows.append({'classId': identity[0], 'abilityId': identity[1],
                     'nameFromRawDbc': draft['ranks'][0].get('nameFromRawDbc'),
                     'sourceRankCount': len(draft['ranks']), 'declaredDevelopmentProfile': declaration,
                     'candidateOutcomeRoutes': draft['candidateOutcomeRoutes'],
                     'actionTraits': draft['actionTraits'], 'requiredReviews': draft['requiredReviews'],
                     'productionApproved': False, 'runtimeQualified': False})
    if set(declarations) - seen:
        raise ValueError('Declared profile absent from source-consistent drafts')
    rows.sort(key=lambda row: (row['classId'], row['abilityId']))
    classes = sorted({row['classId'] for row in rows})

    def summarize(selected):
        pending = [row for row in selected if not row['declaredDevelopmentProfile']]
        kinds = Counter(row['declaredDevelopmentProfile']['kind'] for row in selected
                        if row['declaredDevelopmentProfile'])
        return {'sourceGroupCount': len(selected), 'declaredDevelopmentProfileCount': sum(kinds.values()),
                'profileDeclarationCount': sum(len(row['declaredDevelopmentProfile']['sources']) for row in selected
                                               if row['declaredDevelopmentProfile']),
                'sharedDeclarationProfileCount': sum(bool(row['declaredDevelopmentProfile'] and
                    row['declaredDevelopmentProfile']['requiresRuntimeEquivalenceCheck']) for row in selected),
                'declaredDevelopmentKinds': dict(sorted(kinds.items())), 'needsDefinitionCount': len(pending),
                'needsDefinitionWithRawOutcomeCount': sum(bool(row['candidateOutcomeRoutes']) for row in pending),
                'pendingRankedGroupCount': sum(row['sourceRankCount'] > 1 for row in pending),
                'pendingStandaloneGroupCount': sum(row['sourceRankCount'] == 1 for row in pending)}

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
