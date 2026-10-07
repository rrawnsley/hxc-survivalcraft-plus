import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re


def verify_provenance(candidates, root, dbc):
    sources = candidates.get('sources')
    if not isinstance(sources, list) or not sources:
        raise ValueError('Missing source provenance')
    native_sources = candidates.get('nativeOutcomeSources')
    expected = {'modules/mod-ability-practice/src/AbilityPracticeServer.cpp',
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
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentConjureFixed.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentPassiveFixed.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentUtilityFixed.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentControlFixed.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentLeech.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentBuffs.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentTrainerFixed.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentTrainerRanks.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentBuffTrainerRanks.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentStatBuffTrainerRanks.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentSpellPowerBuffTrainerRanks.h',
                'modules/mod-ability-practice/tools/trainer_rank_extensions.py',
                'modules/mod-ability-practice/tools/trainer_acquisition_review.py',
                'data/sql/updates/pending_db_world/rev_20260923_05_coa_class_trainer_core.sql',
                'src/server/coa/AscensionLiveBaselineData.h',
                'src/server/game/Handlers/CombatHandler.cpp',
                'src/server/game/Entities/Creature/Trainer.h',
                'src/server/game/Entities/Creature/Trainer.cpp',
                'src/server/game/Globals/ObjectMgr.h',
                'src/server/game/Globals/ObjectMgr.cpp',
                'modules/mod-ability-practice/tools/rank_pacing_development.py',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentPacing.h',
                'modules/mod-ability-practice/src/AbilityPracticeDevelopmentRankCaps.h',
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
                'src/server/coa/AscensionReaperTalents.cpp',
                'data/sql/updates/pending_db_world/rev_20260915_01_soul_capture.sql',
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
                'modules/mod-ability-practice/src/AbilityPracticeProgression.h', 'src/server/shared/SharedDefines.h',
                'src/server/game/Spells/AbilityPracticeMasteryPolicy.h',
                'src/server/coa/AscensionSpellEligibility.h', 'src/server/coa/AscensionRacialAbilities.h',
                'src/server/coa/AscensionFelsworn.cpp',
                'src/server/coa/AscensionFelswornAuras.cpp',
                'src/server/coa/AscensionFelswornContracts.cpp',
                'src/server/coa/AscensionFelswornData.h', 'src/server/coa/AscensionFelswornSummons.cpp',
                'src/server/coa/AscensionXorothAbilities.cpp', 'src/server/coa/AscensionXorothData.h',
                'src/server/coa/AscensionXorothContracts.cpp', 'src/server/coa/AscensionCompat.cpp',
                'src/server/coa/AscensionStarcallerAbilities.cpp',
                         'src/server/coa/AscensionStarcallerEvents.cpp',
                         'src/server/coa/AscensionClassMechanics.cpp', 'src/server/game/Entities/Player/Player.cpp',
                         'src/server/game/Entities/Player/AbilityPracticeRankPolicy.h',
                         'src/server/coa/AbilityPracticeRankPolicy.cpp',
                'src/server/coa/AscensionNecromancerContracts.cpp', 'src/server/coa/AscensionReaperDeathwind.cpp',
                'src/server/coa/AscensionTemplar.cpp',
                'src/server/coa/AscensionTemplarAbilities.cpp',
                'src/server/coa/AscensionTemplarData.h',
                'src/server/coa/AscensionTemplarEvents.cpp',
                'src/server/game/Spells/AbilityPracticeCastReceipt.h', 'src/server/game/Spells/Spell.h',
                'src/server/game/Spells/Spell.cpp',
                'src/server/game/Spells/SpellInfo.cpp', 'src/server/game/Spells/SpellEffects.cpp',
                'src/server/game/Spells/Auras/SpellAuras.h', 'src/server/game/Spells/Auras/SpellAuras.cpp',
                'src/server/game/Spells/Auras/SpellAuraEffects.cpp',
                'src/server/game/Spells/Auras/SpellAuraEffects.h',
                'src/server/game/Entities/Unit/Unit.h', 'src/server/game/Entities/Unit/Unit.cpp',
                'src/server/game/Entities/Unit/StatSystem.cpp'}
    expected.update({'src/server/coa/AscensionCultistAuras.cpp',
                     'src/server/coa/AscensionCultist.cpp', 'src/server/coa/AscensionCultist.h',
                     'src/server/coa/AscensionCultistData.h', 'src/server/coa/AscensionCultistContracts.cpp',
                     'data/sql/updates/pending_db_world/rev_20260909_12_cultist_completion.sql',
                     'data/sql/updates/pending_db_world/rev_20260916_61_rite_buffs_exclusive.sql'})
    if not isinstance(native_sources, list) or len(native_sources) != len(expected) or {
            source.get('path') for source in native_sources} != expected:
        raise ValueError('Missing native outcome provenance')
    for source in sources + native_sources:
        relative, expected = source.get('path'), source.get('sha256')
        if not isinstance(relative, str) or not isinstance(expected, str) or not re.fullmatch(
                r'[0-9a-f]{64}', expected):
            raise ValueError('Invalid source provenance')
        path = (root / relative).resolve()
        if not path.is_relative_to(root) or hashlib.sha256(path.read_bytes()).hexdigest() != expected:
            raise ValueError('Changed or foreign source: ' + relative)
    origin = candidates.get('dbcOrigin')
    if not isinstance(origin, dict) or origin.get('file') != 'Spell.dbc':
        raise ValueError('Missing Spell.dbc provenance')
    if Path(origin.get('directory', '')).resolve() != dbc:
        raise ValueError('DBC directory differs from candidate provenance')
    if hashlib.sha256((dbc / 'Spell.dbc').read_bytes()).hexdigest() != origin.get('sha256'):
        raise ValueError('Spell.dbc changed since candidate discovery')
    relative = origin.get('schema_source')
    if not isinstance(relative, str):
        raise ValueError('Missing DBC schema provenance')
    schema = (root / relative).resolve()
    if not schema.is_relative_to(root) or hashlib.sha256(schema.read_bytes()).hexdigest() != origin.get(
            'schema_source_sha256'):
        raise ValueError('DBC schema source changed since candidate discovery')


def raw_cast_profile(raw):
    value = raw.get('castProfile')
    if value is None:
        return None
    fields = ('castingTimeIndex', 'recoveryMilliseconds', 'categoryRecoveryMilliseconds',
              'startRecoveryMilliseconds')
    if not isinstance(value, dict) or set(value) != {*fields, 'scope'} or value['scope'] != (
            'raw-dbc-timing-not-measured-use-frequency'):
        raise ValueError('Invalid raw cast timing shape or scope')
    if any(type(value[field]) is not int or not 0 <= value[field] <= 4294967295 for field in fields):
        raise ValueError('Invalid raw cast timing value')
    return {field: value[field] for field in (*fields, 'scope')}



def raw_channel_profile(raw):
    value = raw.get('channelProfile')
    fields = {'attributesEx', 'durationIndex', 'channelFlagMask', 'channeled', 'scope'}
    if not isinstance(value, dict) or set(value) != fields or value['scope'] != (
            'raw-channel-timing-not-measured-effective-duration'):
        raise ValueError('Missing or invalid raw channel timing shape or scope')
    if any(type(value[field]) is not int or not 0 <= value[field] <= 4294967295
           for field in ('attributesEx', 'durationIndex', 'channelFlagMask')):
        raise ValueError('Invalid raw channel timing value')
    if value['channelFlagMask'] != 68 or type(value['channeled']) is not bool or (
            value['channeled'] != bool(value['attributesEx'] & value['channelFlagMask'])):
        raise ValueError('Raw channel flags disagree with channel classification')
    return dict(value)


def reviewed_passive_baseline_classes(root):
    source = 'src/server/coa/AscensionLiveBaselineData.h'
    text = (root / source).read_text(encoding='utf-8')
    block = re.search(r'array<Spell,\s*315>\s+Spells\s*=\s*\{\{(.*?)\}\};', text, re.S)
    if not block:
        raise ValueError('Missing reviewed live baseline spell table')
    rows = re.findall(r'\{\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\}', block[1])
    if len(rows) != 315:
        raise ValueError('Live baseline spell table shape changed')
    expected = {552011: set(range(12, 33)), 536213: {13}, 632621: {16}, 28875: {17}}
    for spell, classes in expected.items():
        actual = [(int(class_id), int(race_id)) for class_id, race_id, spell_id in rows
                  if int(spell_id) == spell]
        if sorted(actual) != [(class_id, 0) for class_id in sorted(classes)]:
            raise ValueError('Reviewed passive class/race baseline evidence changed: ' + str(spell))
    attacks = [(int(class_id), int(race_id)) for class_id, race_id, spell_id in rows if int(spell_id) == 6603]
    if sorted(attacks) != [(class_id, 0) for class_id in range(12, 33)]:
        raise ValueError('Reviewed native melee auto-attack baseline class/race evidence changed')
    return expected


def reviewed_stat_buffs(root):
    text = (root / 'modules/mod-ability-practice/src/AbilityPracticeDevelopmentBuffs.h').read_text(encoding='utf-8')
    body = re.search(r'inline\s+constexpr\s+std::array\s+Mechanics\s*=\s*\{(.*?)\};', text, re.DOTALL)
    if body is None:
        raise ValueError('Missing owned stat-buff mechanic catalog')
    pattern = r'Mechanic\s*\{\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+)(?:,\s*(\d+))?)?\s*\}'
    matches = list(re.finditer(pattern, body[1]))
    if not matches or re.sub(pattern, '', body[1]).replace(',', '').strip():
        raise ValueError('Unsupported owned stat-buff mechanic declaration')
    profiles = {(int(value[1]), int(value[2])) for value in re.finditer(
        r'\{\s*(\d+),\s*(\d+),\s*AbilityKind::Ranked,', text)}
    result = {}
    for match in matches:
        class_id, ability_id, target, stat = map(int, match.groups()[:4])
        aura = int(match[5]) if match[5] is not None else 29
        effect_index = int(match[6]) if match[6] is not None else 0
        if (not 12 <= class_id <= 32 or not ability_id or target not in {21, 56} or
                not (aura == 29 and stat in range(5) or aura == 345 and stat == 127 and target == 21 or
                     aura == 85 and stat == 0 and target == 21 or
                     aura == 143 and stat in {4, 16, 64, 126} and target == 21) or
                ((effect_index != 0 or aura == 143 and stat == 126) and not (
                    effect_index == 2 and aura == 143 and stat == 126 and
                    (class_id, ability_id) in {(16, 575843), (30, 575839)}))):
            raise ValueError('Unsupported owned stat-buff mechanic')
        identity = (class_id, ability_id)
        if identity in result:
            raise ValueError('Duplicate owned stat-buff mechanic')
        result[identity] = {'scope': 'reviewed-source-shape-not-effective-runtime-buff',
                            'targetA': target, 'statSelector': stat, 'auraId': aura, 'effectIndex': effect_index}
    if set(result) != profiles:
        raise ValueError('Owned stat-buff profiles and mechanics differ')
    if (30, 575839) in result:
        rites = (root / 'data/sql/updates/pending_db_world/rev_20260916_61_rite_buffs_exclusive.sql').read_text(
            encoding='utf-8')
        family = [int(value) for value in re.findall(r'\(2100001,\s*(\d+)\)', rites)]
        if family != [575839, 575842, 578126, 578130, 800198, 680298, 1]:
            raise ValueError('Native Rite exclusive group source changed')
        result[(30, 575839)]['nativeExclusiveGroupId'] = 2100001
        result[(30, 575839)]['nativeExclusiveFamilySpellIds'] = family[:-1]
    whispers = {(25, 561389): (561389, 561390, 561391), (25, 572791): (572791, 572819, 572905)}
    if set(result).intersection(whispers):
        lifecycle = (root / 'src/server/coa/AscensionCultistAuras.cpp').read_text(encoding='utf-8')
        families = [tuple(int(value.strip()) for value in match[1].split(',')) for match in
                    re.finditer(r'std::vector<uint32>\s*\{([\d,\s]+)\}', lifecycle)]
        expected = (561386, 561387, 561389, 561390, 561391, 561392, 572637, 572791, 572819, 572905, 573067)
        if families.count(expected) != 1:
            raise ValueError('Native Cultist exclusive whisper family changed')
        bindings = (root / 'data/sql/updates/pending_db_world/rev_20260909_12_cultist_completion.sql').read_text(
            encoding='utf-8-sig')
        for identity, spells in whispers.items():
            if identity not in result:
                continue
            for spell in spells:
                pattern = (r"INSERT\s+INTO\s+`spell_script_names`\s*\(`spell_id`,\s*`ScriptName`\)\s*VALUES\s*"
                           r"\(\s*" + str(spell) + r",\s*'aura_ascension_cultist_lifecycle'\s*\)\s*;")
                if len(re.findall(pattern, bindings)) != 1:
                    raise ValueError('Missing or ambiguous source Cultist whisper lifecycle binding')
            result[identity]['nativeExclusiveFamilySpellIds'] = list(expected)
    return result


def build_drafts(candidates, root):
    stat_buffs = reviewed_stat_buffs(root)
    baseline_source = 'modules/mod-ability-practice/src/AbilityPracticeBaseline.h'
    baseline_text = (root / baseline_source).read_text(encoding='utf-8')
    baseline_match = re.search(r'NativeBaselineSpells\s*=\s*\{([\d,\s]+)\}\s*;', baseline_text)
    if not baseline_match:
        raise ValueError('Missing reviewed native baseline list')
    baseline_ids = [int(value.strip()) for value in baseline_match[1].split(',')]
    if baseline_ids != [75, 81, 107, 674, 2764, 3018, 3124, 5019, 6603, 28875, 536213, 552011, 632621]:
        raise ValueError('Native baseline scope needs explicit authoring review')
    if candidates.get('schemaVersion') != 1 or candidates.get('scope') != (
            'source-review-candidates-not-runtime-definitions'):
        raise ValueError('Unsupported candidate artifact')
    passive_classes = reviewed_passive_baseline_classes(root)
    passive_drafts = {spell: set() for spell in passive_classes}
    melee_drafts = set()
    trigger_review = candidates.get('rawTriggerReferenceReview')
    if (not isinstance(trigger_review, dict) or trigger_review.get('dbcOrigin') != candidates.get('dbcOrigin')
            or trigger_review.get('scope') != 'raw-dbc-references-not-executed-casts-or-practice-eligibility'
            or trigger_review.get('requiresLoadedDataScriptAndOriginalCastQualification') is not True
            or not isinstance(trigger_review.get('graphs'), list)):
        raise ValueError('Missing raw trigger-reference review')
    trigger_graphs = {}
    for graph in trigger_review['graphs']:
        spell = graph.get('rootSpellId')
        if (type(spell) is not int or not 1 <= spell <= 4294967295 or spell in trigger_graphs
                or graph.get('runtimeQualified') is not False
                or not isinstance(graph.get('detectedCyclePaths'), list)
                or not isinstance(graph.get('incompleteReasons'), list)):
            raise ValueError('Invalid or duplicate raw trigger-reference graph')
        trigger_graphs[spell] = graph
    drafts = []
    identities = set()
    for candidate in candidates['candidates']:
        if candidate.get('productionApproved') is not False or candidate.get('classification') != 'pending':
            raise ValueError('Expected unapproved review candidates')
        review = candidate.get('nativeClassGrantReview', {})
        trainer = candidate['classId'] == 14 and candidate['sourceReferenceSpellId'] in {535598, 535599, 535600}
        if trainer:
            supplemental = candidate.get('nativeTrainerSourceReview', {})
            entries = supplemental.get('members', [])
            if (supplemental.get('status') != 'needs-effective-trainer-and-design-review'
                    or supplemental.get('blockingFlags') or len(entries) != 1
                    or entries[0].get('rawEffects') != [50, 0, 0] or entries[0].get('rawPassive') is not False
                    or not entries[0].get('nativeRiftMapping')):
                raise ValueError('Reviewed trainer rift source evidence changed')
            offers = entries[0].get('sourceTrainerOffers', [])
            if (len(offers) != 1 or offers[0]['trainerId'] != 900014 or offers[0]['requiredSkillLine']
                    or offers[0]['requiredSkillRank'] or offers[0]['requiredAbilities']):
                raise ValueError('Reviewed trainer rift prerequisites changed')
            review = {'sourceChainConsistent': True, 'blockingFlags': [],
                      'status': 'needs-unranked-kind-and-effective-review',
                      'sourceRanks': [{'spellId': entries[0]['spellId'],
                                       'characterLevel': offers[0]['characterLevel'], 'rawRankNumber': None}]}
        if review.get('sourceChainConsistent') is not True:
            continue
        if review.get('blockingFlags') or review.get('status') not in {
                'needs-unranked-kind-and-effective-review', 'needs-effective-data-and-design-review'}:
            raise ValueError('Contradictory class-grant review')
        class_id, ability_id = candidate['classId'], candidate['sourceReferenceSpellId']
        if type(class_id) is not int or not 1 <= class_id <= 255 or type(ability_id) is not int or not (
                1 <= ability_id <= 4294967295):
            raise ValueError('Invalid draft identity')
        if (class_id, ability_id) in identities:
            raise ValueError('Duplicate draft identity')
        identities.add((class_id, ability_id))
        members = {member['spellId']: member for member in candidate['members']}
        if len(members) != len(candidate['members']):
            raise ValueError('Duplicate candidate member')
        source_ranks = review.get('sourceRanks', [])
        if not 1 <= len(source_ranks) <= 64 or len(members) != len(source_ranks):
            raise ValueError('Invalid source rank count')
        ranks, seen = [], set()
        for ordinal, rank in enumerate(source_ranks, 1):
            spell, level = rank.get('spellId'), rank.get('characterLevel')
            if type(spell) is not int or not 1 <= spell <= 4294967295 or spell not in members or spell in seen:
                raise ValueError('Invalid source rank identity')
            if type(level) is not int or not 1 <= level <= 255 or (
                    ranks and level < ranks[-1]['characterLevel']):
                raise ValueError('Invalid source rank level')
            if len(source_ranks) > 1 and rank.get('rawRankNumber') != ordinal:
                raise ValueError('Invalid source rank order')
            if ordinal == 1 and spell != ability_id:
                raise ValueError('Class grant must be first')
            seen.add(spell)
            raw = members[spell].get('rawDbc') or {}
            ranks.append({'rankNumber': ordinal, 'spellId': spell, 'characterLevel': level,
                          'nameFromRawDbc': raw.get('name'), 'proficiencyRequired': None,
                          'rawCastProfile': raw_cast_profile(raw),
                          'rawChannelProfile': raw_channel_profile(raw)})
        baseline = ability_id in baseline_ids
        baseline_effects = {75: 58, 81: 20, 107: 23, 674: 40, 2764: 58, 3018: 58, 3124: 22, 5019: 17, 6603: 78}
        passive_effects = {552011: [6, 6, 0], 536213: [6, 0, 0], 632621: [6, 0, 0], 28875: [6, 0, 0]}
        if baseline:
            baseline_raw = members[ability_id].get('rawDbc', {})
            expected_passive = ability_id not in {75, 2764, 3018, 5019, 6603}
            if (len(ranks) != 1 or ranks[0]['characterLevel'] != 1 or
                    baseline_raw.get('passive') is not expected_passive or
                    baseline_raw.get('effects') != (passive_effects[ability_id] if ability_id in passive_effects
                                                    else [baseline_effects[ability_id], 0, 0])):
                raise ValueError('Native baseline raw/source evidence changed')
            if ability_id == 6603:
                details = baseline_raw.get('effectDetails', [])
                expected = [(78, 0, 0, 0, 0), (0, 0, 0, 0, 0), (0, 0, 0, 0, 0)]
                if (class_id not in range(12, 33) or baseline_raw.get('name') != 'Auto Attack' or
                        baseline_raw.get('rankLabel') or baseline_raw.get('baseLevel') != 0 or
                        baseline_raw.get('spellLevel') != 0 or len(details) != 3 or
                        [(v.get('effectId'), v.get('auraId'), v.get('implicitTargetA'),
                          v.get('implicitTargetB'), v.get('triggerSpellId')) for v in details] != expected):
                    raise ValueError('Reviewed melee auto-attack raw/source evidence changed')
                melee_drafts.add(class_id)
            if ability_id in passive_classes:
                details = baseline_raw.get('effectDetails', [])
                expected = ([(6, 108, 1, 0, 0), (6, 108, 1, 0, 0), (0, 0, 0, 0, 0)] if ability_id == 552011
                            else [(6, 98, 1, 0, 0), (0, 0, 0, 0, 0), (0, 0, 0, 0, 0)])
                native_level = 1 if ability_id == 552011 else 0
                if (class_id not in passive_classes[ability_id] or len(details) != 3 or
                        [(v.get('effectId'), v.get('auraId'), v.get('implicitTargetA'),
                          v.get('implicitTargetB'), v.get('triggerSpellId')) for v in details] != expected or
                        baseline_raw.get('baseLevel') != native_level or
                        baseline_raw.get('spellLevel') != native_level):
                    raise ValueError('Reviewed raw passive baseline evidence changed: ' + str(ability_id))
                passive_drafts[ability_id].add(class_id)
        routes = candidate.get('nativeOutcomeReview', {}).get('commonRoutes', [])
        if not isinstance(routes, list) or len(set(routes)) != len(routes) or any(route not in {
                'damage', 'healing', 'interrupt', 'dispel', 'steal', 'fear', 'stun', 'root'} for route in routes):
            raise ValueError('Invalid candidate outcome routes')
        periodic = candidate.get('nativePeriodicReview', {}).get('commonRoutes', [])
        if not isinstance(periodic, list) or len(set(periodic)) != len(periodic) or any(
                route not in {'damage', 'healing'} for route in periodic):
            raise ValueError('Invalid candidate periodic outcome routes')
        required = ['effective-data', 'classification', 'acquisition-ownership', 'meaningful-outcome',
                    'practice-rates-and-caps', 'persistence-and-migration', 'menu-and-gameplay-qualification']
        raw_graphs = [trigger_graphs[rank['spellId']] for rank in ranks if rank['spellId'] in trigger_graphs]
        trigger_summary = {
            'rootSpellIds': [graph['rootSpellId'] for graph in raw_graphs],
            'rootsWithDetectedCycles': [graph['rootSpellId'] for graph in raw_graphs
                                       if graph['detectedCyclePaths']],
            'incompleteRootSpellIds': [graph['rootSpellId'] for graph in raw_graphs
                                       if graph['incompleteReasons']],
            'runtimeQualified': False,
        }
        if raw_graphs:
            required.append('trigger-reference-loaded-data-script-and-original-cast-attribution')
        if trigger_summary['rootsWithDetectedCycles']:
            required.append('cyclic-raw-trigger-reference-execution-review')
        if trigger_summary['incompleteRootSpellIds']:
            required.append('incomplete-raw-trigger-reference-review')
        if class_id == 30 and ability_id == 561289:
            required.extend(['soul-capture-loaded-script-registration-and-trigger-suppression',
                             'soul-capture-corpse-resource-and-post-combat-use-design'])
        if class_id == 19 and ability_id == 806521:
            required.append('titanstrike-loaded-aura-duration-helper-and-original-leech-damage')
        if (class_id, ability_id) in {(12, 570122), (24, 804662), (28, 804154)}:
            raw = members[ability_id].get('rawDbc', {})
            details = raw.get('effectDetails', [])
            base_points = 14 if ability_id == 804662 else 4
            intro_level = 14 if ability_id == 804154 else 16
            helper_slot = (64, 0, 1, 0, 71495, 0, 0) if ability_id == 804154 else (0, 0, 0, 0, 0, 0, 0)
            expected = [(33, 0, 26, 0, 0, 1, base_points), helper_slot,
                        (0, 0, 0, 0, 0, 0, 0)]
            if (len(ranks) != 1 or ranks[0]['characterLevel'] != intro_level or raw.get('passive') is not False or
                    raw.get('rankLabel') or len(details) != 3 or [(v.get('effectId'), v.get('auraId'),
                        v.get('implicitTargetA'), v.get('implicitTargetB'), v.get('triggerSpellId'),
                        v.get('miscValue'), v.get('basePoints')) for v in details] != expected):
                raise ValueError('Reviewed lock utility source/raw evidence changed')
            required.append('native-lock-requirements-and-existing-skill-progression-preserved')
        if (class_id, ability_id) in stat_buffs:
            mechanic = stat_buffs[(class_id, ability_id)]
            effect_index = mechanic['effectIndex']
            expected = [(0, 0, 0, 0, 0, 0)] * 3
            expected[effect_index] = (6, mechanic['auraId'], mechanic['targetA'], 0, 0, mechanic['statSelector'])
            amounts = []
            for rank in ranks:
                raw = members[rank['spellId']].get('rawDbc', {})
                details = raw.get('effectDetails', [])
                if raw.get('passive') is not False or len(details) != 3 or [(v.get('effectId'),
                        v.get('auraId'), v.get('implicitTargetA'), v.get('implicitTargetB'),
                        v.get('triggerSpellId'), v.get('miscValue')) for v in details] != expected or (
                        type(details[effect_index].get('basePoints')) is not int or
                        details[effect_index]['basePoints'] < 0):
                    raise ValueError('Reviewed owned stat-buff source shape changed')
                amounts.append(details[effect_index]['basePoints'] + 1)
            mechanic['rawRankAmounts'] = amounts
            required.extend(['owned-buff-original-application-and-combat-cast-contribution',
                             'buff-contribution-five-second-cadence-and-per-cast-deduplication',
                             'independent-owned-buff-origin-eligibility-and-cadence',
                             'buff-contribution-menu-rule-and-session-qualification'])
            if mechanic['auraId'] == 85:
                required.extend(['primary-mana-resource-and-native-regeneration-availability',
                                 'meaningful-combat-practice-not-mana-tick-awards'])
            if mechanic['auraId'] == 143:
                required.append('native-intrinsic-resistance-maximum-across-overlapping-school-masks')
                if len(set(amounts)) != len(amounts):
                    required.append('equal-raw-resistance-rank-amounts-need-effective-benefit-review')
            if mechanic.get('nativeExclusiveGroupId'):
                required.append('loaded-native-rite-exclusive-group-and-replacement-pauses-practice')
            if class_id == 25 and ability_id in {561389, 572791}:
                required.extend(['cultist-exclusive-whisper-family-replacement-pauses-original-practice',
                                 'loaded-cultist-lifecycle-binding-and-original-buff-receipt',
                                 'cultist-refresh-helper-casts-cannot-earn-buff-practice'])
            if ability_id == 680302:
                expected_spells = [680302, 681439, 681440, 681441]
                expected_levels = [24, 36, 48, 58]
                expected_points = [19, 31, 42, 53]
                if ([rank['spellId'] for rank in ranks] != expected_spells or
                        [rank['characterLevel'] for rank in ranks] != expected_levels):
                    raise ValueError('Enduring Shout native source ladder changed')
                for spell, points in zip(expected_spells, expected_points):
                    raw = members[spell].get('rawDbc', {})
                    details = raw.get('effectDetails', [])
                    expected = [(6, 29, 56, 0, 0, 2, points), (0, 0, 0, 0, 0, 0, 0),
                                (0, 0, 0, 0, 0, 0, 0)]
                    if raw.get('passive') is not False or len(details) != 3 or [(v.get('effectId'),
                            v.get('auraId'), v.get('implicitTargetA'), v.get('implicitTargetB'),
                            v.get('triggerSpellId'), v.get('miscValue'), v.get('basePoints'))
                            for v in details] != expected:
                        raise ValueError('Enduring Shout reviewed stat-buff raw evidence changed')
        if candidate.get('nativeOutcomeReview', {}).get('directLeechReview', {}).get('commonRoutes'):
            required.append('original-health-leech-damage-attribution')
        if periodic:
            required.append('periodic-original-cast-attribution')
        if set(routes) & {'fear', 'stun', 'root'}:
            required.append('control-original-cast-and-new-application-attribution')
        if len(ranks) == 1:
            required.append('unranked-mastery-or-fixed-design')
        if trainer:
            required.extend(['loaded-class-trainer-owner-and-offer', 'native-race-and-faction-eligibility',
                             'effective-native-rift-mapping'])
        drafts.append({'classId': class_id, 'abilityId': ability_id, 'definitionVersion': None,
                       'acquisitionSource': 'class-trainer-source-evidence' if trainer else
                                            'class-grant-source-evidence', 'productionApproved': False,
                       'kind': None, 'outcome': None,
                       'nativeBaselineExclusion': {'source': baseline_source,
                           'reason': ('native-passive-baseline-remains-native' if ability_id in passive_classes else
                                      'native-combat-baseline-remains-native')} if baseline else None,
                       'candidateOutcomeRoutes': list(routes),
                       'candidatePeriodicOutcomeRoutes': list(periodic), 'ranks': ranks,
                       'rawTriggerReferenceSummary': trigger_summary,
                       'rawVisibilityReview': candidate.get('rawVisibilityReview'),
                       'proficiencyCaps': [], 'trainingBands': [], 'masteryRewards': [],
                       'reviewFlags': list(candidate['reviewFlags']),
                       'actionTraits': list(candidate['rawActionReview']['traits']),
                       'ownedStatBuffReview': stat_buffs.get((class_id, ability_id)),
                       'requiredReviews': required})
    if passive_drafts != passive_classes:
        raise ValueError('Reviewed passive baseline class grants are incomplete')
    if melee_drafts != set(range(12, 33)):
        raise ValueError('Reviewed melee auto-attack baseline class grants are incomplete')
    drafts.sort(key=lambda draft: (draft['classId'], draft['abilityId']))
    classes = Counter(draft['classId'] for draft in drafts)
    return {'schemaVersion': 1, 'scope': 'unapproved-definition-drafts-not-runtime-profiles',
            'productionApproved': False, 'sources': candidates['sources'],
            'nativeOutcomeSources': candidates['nativeOutcomeSources'], 'dbcOrigin': candidates['dbcOrigin'],
            'summary': {'classCount': len(classes), 'draftCount': len(drafts),
                        'rankedSourceGroupCount': sum(len(draft['ranks']) > 1 for draft in drafts),
                        'standaloneSourceGroupCount': sum(len(draft['ranks']) == 1 for draft in drafts),
                        'nativeBaselineExclusionCount': sum(bool(draft['nativeBaselineExclusion']) for draft in drafts),
                        'withRawChannelInfoCount': sum(all(rank.get('rawChannelProfile') for rank in draft['ranks'])
                                                       for draft in drafts),
                        'withCandidateOutcomeCount': sum(bool(draft['candidateOutcomeRoutes']) for draft in drafts),
                        'withCandidatePeriodicOutcomeCount': sum(bool(draft['candidatePeriodicOutcomeRoutes'])
                                                                for draft in drafts)},
            'classes': [{'classId': identity, 'draftCount': count} for identity, count in sorted(classes.items())],
            'drafts': drafts}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--candidates', type=Path, required=True)
    parser.add_argument('--dbc', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[3])
    args = parser.parse_args()
    candidates = json.loads(args.candidates.read_text(encoding='utf-8'))
    verify_provenance(candidates, args.root.resolve(), args.dbc.resolve())
    result = build_drafts(candidates, args.root.resolve())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps(result['summary'], sort_keys=True))


if __name__ == '__main__':
    main()
