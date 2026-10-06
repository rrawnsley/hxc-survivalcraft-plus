import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re
import sys


DIRECT_ROUTES = {'damage': {2, 17, 31, 58, 121}, 'healing': {10, 67, 136}}
OUTCOME_ROUTES = {**DIRECT_ROUTES, 'interrupt': {68}, 'dispel': {38}, 'steal': {126}}
PERIODIC_ROUTES = {'damage': {3, 53, 89}, 'healing': {8}}
CONTROL_ROUTES = {'fear': {7}, 'stun': {12}, 'root': {26}}
DEPRECATED_WORD = re.compile(r'(?<![a-z0-9_])(?:deprecated|depreacated)(?![a-z0-9_])', re.IGNORECASE | re.ASCII)


def raw_player_deprecated(raw):
    return any(isinstance(raw.get(field), str) and DEPRECATED_WORD.search(raw[field])
               for field in ('name', 'rankLabel'))


def action_review(members):
    traits, triggers, timing = set(), set(), []
    direct = {'SPELL_EFFECT_SCHOOL_DAMAGE', 'SPELL_EFFECT_WEAPON_DAMAGE',
              'SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL', 'SPELL_EFFECT_NORMALIZED_WEAPON_DMG',
              'SPELL_EFFECT_WEAPON_PERCENT_DAMAGE',
              'SPELL_EFFECT_HEAL', 'SPELL_EFFECT_HEAL_PCT', 'SPELL_EFFECT_HEAL_MAX_HEALTH',
              'SPELL_EFFECT_HEALTH_LEECH'}
    utility = {'SPELL_EFFECT_INTERRUPT_CAST', 'SPELL_EFFECT_DISPEL', 'SPELL_EFFECT_DISPEL_MECHANIC',
               'SPELL_EFFECT_STEAL_BENEFICIAL_BUFF', 'SPELL_EFFECT_RESURRECT', 'SPELL_EFFECT_RESURRECT_NEW'}
    for member in members:
        raw = member.get('rawDbc')
        if not raw or raw.get('fieldErrors'):
            traits.add('missing-or-invalid-raw-effect-evidence')
            continue
        if raw.get('passive'):
            traits.add('passive-flag-review')
        if raw_player_deprecated(raw):
            traits.add('deprecated-player-spell')
        details = raw.get('effectDetails')
        if not details:
            traits.add('missing-or-invalid-raw-effect-evidence')
        for effect in details or []:
            name, aura = effect.get('effectName') or '', effect.get('auraName') or ''
            if name in direct:
                traits.add('direct-outcome-review')
            if name in utility:
                traits.add('utility-outcome-review')
            if aura.startswith('SPELL_AURA_PERIODIC_'):
                traits.add('periodic-attribution-review')
            if name == 'SPELL_EFFECT_APPLY_AURA' and aura in {
                    'SPELL_AURA_MOD_FEAR', 'SPELL_AURA_MOD_STUN', 'SPELL_AURA_MOD_ROOT'}:
                traits.add('control-effect-attribution-review')
            if name.startswith('SPELL_EFFECT_SUMMON') or name == 'SPELL_EFFECT_CREATE_TAMED_PET':
                traits.add('pet-or-summon-ownership-review')
            trigger = effect.get('triggerSpellId', 0)
            if trigger:
                triggers.add(trigger)
            if trigger or 'TRIGGER' in name or 'TRIGGER' in aura:
                traits.add('triggered-attribution-review')
            if name in {'SPELL_EFFECT_DUMMY', 'SPELL_EFFECT_SCRIPT_EFFECT'} or aura == 'SPELL_AURA_DUMMY':
                traits.add('scripted-behavior-review')
            if effect.get('effectId') and not name:
                traits.add('unknown-raw-effect-review')
            if effect.get('auraId') and not aura:
                traits.add('unknown-raw-aura-review')
        if raw.get('castProfile'):
            timing.append({'spellId': member['spellId'], **raw['castProfile']})
    return {'traits': sorted(traits), 'triggerSpellIds': sorted(triggers), 'castProfiles': timing,
            'scope': 'raw-action-routing-review-not-runtime-qualification'}


def raw_periodic_auras(raw, effects):
    details = raw.get('effectDetails')
    if not isinstance(details, list) or len(details) != 3 or any(
            not isinstance(detail, dict) or detail.get('index') != index
            or type(detail.get('effectId')) is not int or detail['effectId'] != effects[index]
            or type(detail.get('auraId')) is not int or detail['auraId'] < 0
            for index, detail in enumerate(details)):
        return None
    return {detail['auraId'] for detail in details if detail['effectId'] == 6}


def native_route_review(members, route_ids, scope, missing_reason, periodic=False):
    routes = set(route_ids)
    blocked = []
    for member in members:
        raw = member.get('rawDbc')
        reasons = []
        if not raw or raw.get('fieldErrors') or type(raw.get('passive')) is not bool:
            reasons.append('missing-or-invalid-raw-evidence')
        elif raw_player_deprecated(raw):
            reasons.append('deprecated-player-spell')
        elif raw['passive']:
            reasons.append('passive-spell')
        else:
            effects = raw.get('effects')
            if not isinstance(effects, list) or len(effects) != 3 or any(
                    type(effect) is not int or effect < 0 for effect in effects):
                reasons.append('missing-or-invalid-raw-effects')
            else:
                identities = raw_periodic_auras(raw, effects) if periodic else effects
                if identities is None:
                    reasons.append('missing-or-invalid-raw-aura-details')
                else:
                    supported = {route for route, values in route_ids.items() if values.intersection(identities)}
                    if not supported:
                        reasons.append(missing_reason)
                    routes.intersection_update(supported)
        if reasons:
            blocked.append({'spellId': member['spellId'], 'reasons': reasons})
    if blocked:
        routes.clear()
    return {
        'scope': scope,
        'nativeSource': 'modules/mod-ability-practice/src/AbilityPracticeServer.cpp',
        'commonRoutes': sorted(routes), 'blockedMembers': blocked,
        'status': 'needs-effective-data-and-acquisition-review' if routes else
                  'needs-outcome-adapter-review' if not blocked else 'blocked-by-member-evidence',
    }


def native_direct_review(members):
    return native_route_review(members, DIRECT_ROUTES,
                               'raw-native-direct-route-comparison-not-effective-data-approval',
                               'no-current-direct-route')


def native_outcome_review(members):
    result = native_route_review(members, OUTCOME_ROUTES,
                                'raw-native-outcome-route-comparison-not-effective-data-approval',
                                'no-current-native-outcome-route')
    control = native_route_review(members, CONTROL_ROUTES,
                                  'raw-native-control-route-comparison-not-attribution-or-effective-data-approval',
                                  'no-current-native-control-route', periodic=True)
    if control['commonRoutes']:
        result['commonRoutes'] = sorted(set(result['commonRoutes']) | set(control['commonRoutes']))
        result['blockedMembers'] = []
        result['status'] = 'needs-effective-data-and-acquisition-review'
    result['controlReview'] = control
    return result


def native_periodic_review(members):
    return native_route_review(members, PERIODIC_ROUTES,
                               'raw-native-periodic-route-comparison-not-attribution-or-effective-data-approval',
                               'no-current-native-periodic-route', periodic=True)


def native_class_grant_review(root_spell, members):
    root = next((member for member in members if member['spellId'] == root_spell), None)
    grants = [entry for entry in (root or {}).get('evidence', [])
              if entry['source'] == 'class-grants' and not entry.get('referenceOnly')]
    result = {'scope': 'source-class-grant-chain-consistency-not-runtime-entitlement',
              'sources': ['src/server/coa/AscensionCustomClassData.h',
                          'src/server/coa/AscensionSpellProgressionData.h'],
              'sourceChainConsistent': False, 'blockingFlags': [], 'sourceRanks': []}
    if not grants:
        return {**result, 'status': 'no-class-grant-root'}
    flags = set()
    if len(members) > 64:
        flags.add('native-profile-rank-limit-exceeded')
    ranks = []
    for member in members:
        is_root = member['spellId'] == root_spell
        source = 'class-grants' if is_root else 'generated-progression'
        evidence = [entry for entry in member['evidence']
                    if entry['source'] == source and not entry.get('referenceOnly')]
        if len(evidence) != 1:
            flags.add('missing-or-duplicate-native-level-row')
            continue
        level = evidence[0].get('requiredLevel')
        if type(level) is not int or not 1 <= level <= 255:
            flags.add('native-level-outside-profile-range')
            continue
        ranks.append({'spellId': member['spellId'], 'characterLevel': level,
                      'rawRankNumber': member.get('rawRankNumber')})
    if len(members) > 1:
        raw_ranks = [rank['rawRankNumber'] for rank in ranks]
        if len(ranks) != len(members) or any(type(rank) is not int or rank < 1 for rank in raw_ranks):
            flags.add('raw-rank-order-unresolved')
        elif sorted(raw_ranks) != list(range(1, len(members) + 1)):
            flags.add('raw-rank-sequence-conflict')
        else:
            ranks.sort(key=lambda rank: rank['rawRankNumber'])
            if ranks[0]['spellId'] != root_spell:
                flags.add('class-grant-is-not-first-raw-rank')
            if any(later['characterLevel'] < earlier['characterLevel']
                   for earlier, later in zip(ranks, ranks[1:])):
                flags.add('native-level-order-conflict')
    consistent = not flags
    return {**result, 'sourceChainConsistent': consistent, 'blockingFlags': sorted(flags),
            'sourceRanks': ranks,
            'status': 'blocked-by-source-rank-evidence' if flags else
                      'needs-unranked-kind-and-effective-review' if len(members) == 1 else
                      'needs-effective-data-and-design-review'}


def build_candidates(inventory):
    if inventory.get('schemaVersion') != 1:
        raise ValueError('Unsupported source inventory schema')
    records = {}
    for row in inventory['spells']:
        key = (row['classId'], row['spellId'])
        if key in records or any(type(value) is not int or value <= 0 for value in key):
            raise ValueError('Invalid or duplicate class/spell identity')
        records[key] = row
    groups = defaultdict(set)
    references = defaultdict(list)
    for relation in inventory['relationships']:
        class_id = relation['classId']
        key = (class_id, relation['spellId'])
        root = (class_id, relation['referenceSpellId'])
        if key not in records or root not in records:
            raise ValueError('Relationship refers to an absent class/spell identity')
        if relation['meaning'] == 'claimed-root':
            groups[root].update((root[1], key[1]))
        elif relation['meaning'] == 'acquisition-reference':
            references[key].append(dict(relation))
        else:
            raise ValueError('Unknown relationship meaning')
    membership = defaultdict(set)
    for root, spells in groups.items():
        for spell in spells:
            membership[(root[0], spell)].add(root)
    for key in records:
        if key not in membership:
            groups[key].add(key[1])
    candidates = []
    for root, spells in sorted(groups.items()):
        claimed = root in membership
        members = [records[(root[0], spell)] for spell in sorted(spells)]
        flags = {'effective-data-unverified', 'practice-classification-unreviewed',
                 'claimed-chain-unverified' if claimed else 'unranked-kind-unreviewed'}
        acquisition = []
        for member in members:
            flags.update(member['reviewFlags'])
            key = (root[0], member['spellId'])
            if len(membership[key]) > 1:
                flags.add('conflicting-chain-membership')
            for relation in references[key]:
                acquisition.append(relation)
                if relation['referenceSpellId'] not in spells:
                    flags.add('external-acquisition-prerequisite')
        if claimed:
            if any(len(member['reportedLevels']) != 1 for member in members):
                flags.add('rank-order-unresolved')
            levels = [member['reportedLevels'][0] for member in members if len(member['reportedLevels']) == 1]
            if len(levels) != len(set(levels)):
                flags.add('shared-reported-levels')
            raw_ranks = [member.get('rawRankNumber') for member in members]
            if all(type(rank) is int and rank > 0 for rank in raw_ranks):
                if sorted(raw_ranks) != list(range(1, len(members) + 1)):
                    flags.add('claimed-chain-raw-rank-conflict')
            else:
                flags.add('claimed-chain-raw-ranks-unresolved')
        candidates.append({
            'classId': root[0], 'sourceReferenceSpellId': root[1],
            'sourceKind': 'claimed-root-group' if claimed else 'standalone-source',
            'classification': 'pending', 'productionApproved': False,
            'rawActionReview': action_review(members),
            'nativeDirectReview': native_direct_review(members),
            'nativeOutcomeReview': native_outcome_review(members),
            'nativePeriodicReview': native_periodic_review(members),
            'nativeClassGrantReview': native_class_grant_review(root[1], members),
            'members': members,
            'acquisitionReferences': sorted(acquisition, key=lambda row: (
                row['spellId'], row['referenceSpellId'], row['source'])),
            'reviewFlags': sorted(flags),
        })
    counts = Counter(candidate['classId'] for candidate in candidates)
    return {
        'schemaVersion': 1, 'scope': 'source-review-candidates-not-runtime-definitions',
        'sources': inventory['sources'], 'dbcOrigin': inventory.get('dbcOrigin'),
        'summary': {
            'classCount': len(counts), 'candidateCount': len(candidates),
            'claimedRootGroupCount': sum(row['sourceKind'] == 'claimed-root-group' for row in candidates),
            'standaloneSourceCount': sum(row['sourceKind'] == 'standalone-source' for row in candidates),
            'conflictingMembershipCount': sum('conflicting-chain-membership' in row['reviewFlags']
                                             for row in candidates),
            'productionApprovedCount': 0,
            'rawNativeDirectStatuses': dict(sorted(Counter(
                row['nativeDirectReview']['status'] for row in candidates).items())),
            'rawNativeCommonRoutes': dict(sorted(Counter(route for row in candidates
                for route in row['nativeDirectReview']['commonRoutes']).items())),
            'rawNativeOutcomeStatuses': dict(sorted(Counter(
                row['nativeOutcomeReview']['status'] for row in candidates).items())),
            'rawNativeOutcomeCommonRoutes': dict(sorted(Counter(route for row in candidates
                for route in row['nativeOutcomeReview']['commonRoutes']).items())),
            'rawNativePeriodicStatuses': dict(sorted(Counter(
                row['nativePeriodicReview']['status'] for row in candidates).items())),
            'rawNativePeriodicCommonRoutes': dict(sorted(Counter(route for row in candidates
                for route in row['nativePeriodicReview']['commonRoutes']).items())),
            'sourceClassGrantPeriodicCandidateCount': sum(row['nativeClassGrantReview']['sourceChainConsistent']
                and bool(row['nativePeriodicReview']['commonRoutes']) for row in candidates),
            'nativeClassGrantStatuses': dict(sorted(Counter(
                row['nativeClassGrantReview']['status'] for row in candidates).items())),
            'sourceClassGrantOutcomeCandidateCount': sum(row['nativeClassGrantReview']['sourceChainConsistent']
                and bool(row['nativeOutcomeReview']['commonRoutes']) for row in candidates),
            'rawActionTraits': dict(sorted(Counter(trait for candidate in candidates
                for trait in candidate['rawActionReview']['traits']).items())),
        },
        'classes': [{
            'classId': class_id, 'candidateCount': count,
            'rawNativeDirectCandidateCount': sum(bool(row['nativeDirectReview']['commonRoutes'])
                                                for row in candidates if row['classId'] == class_id),
            'rawNativeOutcomeCandidateCount': sum(bool(row['nativeOutcomeReview']['commonRoutes'])
                                                 for row in candidates if row['classId'] == class_id),
            'sourceClassGrantPeriodicCandidateCount': sum(
                row['nativeClassGrantReview']['sourceChainConsistent']
                and bool(row['nativePeriodicReview']['commonRoutes'])
                for row in candidates if row['classId'] == class_id),
            'sourceClassGrantOutcomeCandidateCount': sum(
                row['nativeClassGrantReview']['sourceChainConsistent']
                and bool(row['nativeOutcomeReview']['commonRoutes'])
                for row in candidates if row['classId'] == class_id),
        } for class_id, count in sorted(counts.items())],
        'candidates': candidates,
    }


def native_node_review(node, class_id):
    result = {'scope': 'partial-source-filter-review-not-runtime-entitlement',
              'source': 'src/server/coa/AscensionCoATalentData.cpp', 'status': 'needs-native-review'}
    values = node.get('values', {})
    class_type = node.get('classType', {})
    class_values = class_type.get('values', {})
    if node.get('fieldErrors') or class_type.get('fieldErrors') or not class_values:
        return {**result, 'status': 'missing-or-invalid-class-evidence'}
    native_class = class_values.get('ClassID')
    custom = class_values.get('CustomClass')
    if type(native_class) is not int or type(custom) is not int:
        return {**result, 'status': 'missing-or-invalid-class-evidence'}
    result['referencedClassId'] = native_class
    if not custom:
        return {**result, 'status': 'excluded-non-custom-class-type'}
    if not 12 <= native_class <= 32:
        return {**result, 'status': 'excluded-outside-custom-class-range'}
    if native_class != class_id:
        return {**result, 'status': 'foreign-custom-class-reference'}
    spells = [values.get('RankSpell[' + str(index) + ']') for index in range(5)]
    if any(type(spell) is not int or spell < 0 for spell in spells):
        return {**result, 'status': 'missing-or-invalid-rank-evidence'}
    result['rawRankCount'] = sum(bool(spell) for spell in spells)
    if result['rawRankCount'] > 3:
        return {**result, 'status': 'excluded-more-than-three-native-ranks'}
    if not result['rawRankCount']:
        return {**result, 'status': 'missing-or-invalid-rank-evidence'}
    flags = ['native-level-cost-normalization-unobserved', 'native-dependency-identity-rules-unobserved']
    if values.get('Tab') != 87:
        flags.append('native-class-tab-specialization-join-unobserved')
    for field in ('AbilityEssenceCost', 'TalentEssenceCost', 'RequiredLevel'):
        value = values.get(field)
        if type(value) is not int or value < 0:
            flags.append('missing-or-invalid-cost-level-evidence')
        elif value > 255:
            flags.append('native-byte-width-normalization-review')
    return {**result, 'reviewFlags': sorted(set(flags))}


def annotate_acquisition(candidates, lookup, sources):
    candidates['rawAcquisitionSources'] = sources
    statuses = Counter()
    matching_candidates = 0
    for candidate in candidates['candidates']:
        nodes = {}
        for member in candidate['members']:
            for node in lookup(member['spellId']):
                nodes[node['id']] = {**node}
        candidate['rawAcquisition'] = [nodes[identity] for identity in sorted(nodes)]
        matching = False
        for node in candidate['rawAcquisition']:
            node['nativeLoaderReview'] = native_node_review(node, candidate['classId'])
            status = node['nativeLoaderReview']['status']
            statuses[status] += 1
            matching = matching or status == 'needs-native-review'
        matching_candidates += bool(matching)
        candidate['hasPotentialNativeAcquisitionNode'] = matching
        if nodes:
            candidate['reviewFlags'] = sorted(set(candidate['reviewFlags']) | {
                'native-acquisition-filtering-unobserved'})
    candidates['summary']['withRawAcquisitionCount'] = sum(bool(row['rawAcquisition'])
                                                          for row in candidates['candidates'])
    candidates['summary']['potentialNativeAcquisitionCandidateCount'] = matching_candidates
    candidates['summary']['rawAcquisitionReferenceStatuses'] = dict(sorted(statuses.items()))
    return candidates


def load_acquisition_lookup(root, directory):
    sys.path.insert(0, str(root / 'apps/coa-dbc'))
    from inspect_dbc import DataSet
    dataset = DataSet(directory, root=root)
    loaded = {name: dataset.load(name) for name in (
        'CharacterAdvancement', 'CharacterAdvancementClassTypes', 'CharacterAdvancementTabTypes')}
    table, schema, index, _ = loaded['CharacterAdvancement']
    rank_fields = [field for field in schema.columns if field.name.startswith('RankSpell[')]
    if len(rank_fields) != 5:
        raise ValueError('Reviewed advancement schema must provide five rank spell fields')

    def record(name, identity):
        if identity not in loaded[name][2]:
            return {'id': identity, 'status': 'referenced record absent'}
        selected = dataset.record(name, identity)
        fields = [field for field in selected['fields'] if field['type'] != 'bytes']
        return {
            'values': {field['name']: field['value'] for field in fields},
            'fieldErrors': {field['name']: field['error'] for field in fields if 'error' in field},
        }

    nodes = defaultdict(list)
    for identity, row in sorted(index.items()):
        spells = set()
        for field in rank_fields:
            value, error = dataset.value(table, row, field)
            if error:
                raise ValueError('Invalid advancement rank spell field: ' + error)
            if value:
                spells.add(value)
        if not spells:
            continue
        node = record('CharacterAdvancement', identity)
        values = node['values']
        node.update({
            'id': identity, 'table': 'CharacterAdvancement',
            'classType': record('CharacterAdvancementClassTypes', values['ClassType']),
            'tab': record('CharacterAdvancementTabTypes', values['Tab']),
            'scope': 'raw-data-reference-not-character-entitlement',
        })
        for spell in spells:
            nodes[spell].append(node)
    sources = [{'table': name, 'origin': loaded[name][3]} for name in sorted(loaded)]
    return lambda spell: nodes.get(spell, []), sources


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--inventory', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--dbc', type=Path)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    result = build_candidates(json.loads(args.inventory.read_text(encoding='utf-8')))
    result['nativeOutcomeSources'] = [
        {'path': relative, 'sha256': hashlib.sha256((args.root / relative).read_bytes()).hexdigest()}
        for relative in ('modules/mod-ability-practice/src/AbilityPracticeServer.cpp',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopment.h',
                         'modules/mod-ability-practice/src/AbilityPracticeCatchup.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentSamples.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentPeriodic.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentRanked.h',
                         'modules/mod-ability-practice/tools/ranked_development.py',
                'modules/mod-ability-practice/tools/catalog_candidates.py',
                'modules/mod-ability-practice/tools/inventory.py',
                'modules/mod-ability-practice/tools/profile_drafts.py',
                'modules/mod-ability-practice/tools/coverage.py',
                'modules/mod-ability-practice/tools/pacing_drafts.py',
                'modules/mod-ability-practice/tools/mastery_pacing_drafts.py',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentTrainerFixed.h',
                'modules/mod-ability-practice/tools/trainer_acquisition_review.py',
                'data/sql/updates/pending_db_world/rev_20260923_05_coa_class_trainer_core.sql',
                'src/server/coa/AscensionLiveBaselineData.h',
                'src/server/game/Entities/Creature/Trainer.h',
                'src/server/game/Entities/Creature/Trainer.cpp',
                'src/server/game/Globals/ObjectMgr.h',
                'src/server/game/Globals/ObjectMgr.cpp',
                'modules/mod-ability-practice/tools/rank_pacing_development.py',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentPacing.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentMastery.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentMasteryPacing.h',
                         'modules/mod-ability-practice/src/AbilityPracticeMastery.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentHelpers.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentFixed.h',
                         'modules/mod-ability-practice/src/AbilityPracticeDevelopmentAbsorption.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentControl.h',
                'modules/mod-ability-practice/tools/development-cadences.json',
                'src/server/game/Movement/MotionMaster.h', 'src/server/game/Movement/MotionMaster.cpp',
                         'src/server/coa/AscensionVenomancerAbilities.cpp',
                         'src/server/coa/AscensionSunClericAbilities.cpp',
                         'src/server/coa/AscensionVenomancerAuras.cpp',
                         'src/server/coa/AscensionReaperTalentProcs.h',
                         'src/server/coa/AscensionReaperTalentProcs.cpp',
                'src/server/coa/AscensionBloodmageTalents.cpp',
                'src/server/coa/AscensionBloodmageSecondary.cpp',
                'src/server/coa/AscensionTalentReplacementData.h',
                'src/server/coa/AscensionPrimalistSeismicResources.cpp',
                'src/server/coa/AscensionChronomancerSecondary.cpp',
                'src/server/coa/AscensionChronomancerTalents.cpp',
                'src/server/coa/AscensionCustomResourceData.h',
                'src/server/coa/AscensionPyromancer.cpp',
                'src/server/coa/AscensionPyromancerAbilities.cpp',
                'src/server/coa/AscensionPyromancerAuras.cpp',
                'src/server/coa/AscensionPyromancerContracts.cpp',
                         'modules/mod-ability-practice/src/AbilityPracticeProfiles.h',
                'modules/mod-ability-practice/src/AbilityPracticeBaseline.h',
                'modules/mod-ability-practice/src/AbilityPracticePersistence.h',
                'modules/mod-ability-practice/src/AbilityPracticeOutcome.h',
                'modules/mod-ability-practice/src/AbilityPracticeCatalog.h',
                'modules/mod-ability-practice/src/AbilityPracticeMenu.h',
                'modules/mod-ability-practice/src/AbilityPracticeWire.h',
                'modules/mod-ability-practice/src/AbilityPracticeProgression.h',
                         'src/server/game/Spells/AbilityPracticeMasteryPolicy.h',
                         'src/server/coa/AscensionSpellEligibility.h',
                         'src/server/coa/AscensionRacialAbilities.h',
                         'src/server/coa/AscensionFelsworn.cpp',
                         'src/server/coa/AscensionFelswornAuras.cpp',
                         'src/server/coa/AscensionFelswornContracts.cpp',
                'src/server/coa/AscensionFelswornData.h', 'src/server/coa/AscensionFelswornSummons.cpp',
                'src/server/coa/AscensionXorothAbilities.cpp', 'src/server/coa/AscensionXorothData.h',
                'src/server/coa/AscensionXorothContracts.cpp',
                         'src/server/coa/AscensionCompat.cpp',
                         'src/server/coa/AscensionStarcallerAbilities.cpp',
                         'src/server/coa/AscensionStarcallerEvents.cpp',
                         'src/server/coa/AscensionClassMechanics.cpp',
                         'src/server/coa/AscensionNecromancerContracts.cpp',
                         'src/server/coa/AscensionReaperDeathwind.cpp',
                         'src/server/coa/AscensionTemplar.cpp',
                         'src/server/coa/AscensionTemplarAbilities.cpp',
                         'src/server/coa/AscensionTemplarEvents.cpp',
                         'src/server/game/Entities/Player/Player.cpp',
                         'src/server/game/Entities/Player/AbilityPracticeRankPolicy.h',
                         'src/server/coa/AbilityPracticeRankPolicy.cpp',
                         'src/server/game/Spells/AbilityPracticeCastReceipt.h',
                         'src/server/game/Spells/Spell.h', 'src/server/game/Spells/Spell.cpp',
                'src/server/game/Spells/SpellInfo.cpp',
                         'src/server/game/Spells/SpellEffects.cpp',
                         'src/server/game/Spells/Auras/SpellAuras.h',
                         'src/server/game/Spells/Auras/SpellAuras.cpp',
                         'src/server/game/Spells/Auras/SpellAuraEffects.cpp',
                         'src/server/game/Spells/Auras/SpellAuraEffects.h',
                         'src/server/game/Entities/Unit/Unit.h', 'src/server/game/Entities/Unit/Unit.cpp',
                         'src/server/shared/SharedDefines.h')]
    if args.dbc:
        lookup, sources = load_acquisition_lookup(args.root, args.dbc)
        annotate_acquisition(result, lookup, sources)
        from trainer_acquisition_review import build_review, rift_mappings, source_trainers
        owners, offers = source_trainers(args.root)
        review = build_review(result, owners, offers, rift_mappings(args.root))
        supplemental = {(row['classId'], row['sourceReferenceSpellId']): row for row in review['candidates']}
        for candidate in result['candidates']:
            identity = (candidate['classId'], candidate['sourceReferenceSpellId'])
            if identity in supplemental:
                candidate['nativeTrainerSourceReview'] = supplemental[identity]
        result['summary']['supplementalTrainerSourceReview'] = review['summary']
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
