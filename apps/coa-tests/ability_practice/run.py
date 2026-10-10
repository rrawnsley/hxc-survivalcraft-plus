import os
import re
import copy
import importlib.util
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def check_client(wire_path):
    local_runtime = ROOT / '.cache/ability-practice/lua-runtime'
    if local_runtime.is_dir():
        sys.path.insert(0, str(local_runtime))
    try:
        from lupa.lua51 import LuaRuntime
    except ImportError as error:
        raise RuntimeError('Install lupa with Lua 5.1 support in the isolated verification environment.') from error
    runtime = LuaRuntime()
    client = ROOT / 'modules/mod-ability-practice/client/HXCAbilityPractice'
    for path in (HERE / 'client_mock.lua', client / 'Model.lua', client / 'Wire.lua',
                 client / 'Menu.lua', HERE / 'client_cases.lua'):
        runtime.execute(path.read_text(encoding='utf-8'))
    runtime.globals().EncodedPracticeSnapshot = runtime.table_from(wire_path.read_text().splitlines())
    runtime.execute((HERE / 'client_wire_cases.lua').read_text(encoding='utf-8'))
    snapshots = [runtime.table_from(block.splitlines()) for block in
                 Path(str(wire_path) + '.typed').read_text().strip().split('\n\n')]
    runtime.globals().EncodedTypedPracticeSnapshots = runtime.table_from(snapshots)
    runtime.execute((HERE / 'client_typed_rank_cases.lua').read_text(encoding='utf-8'))
    shared = [runtime.table_from(block.splitlines()) for block in
              Path(str(wire_path) + '.shared').read_text().strip().split('\n\n')]
    runtime.globals().EncodedSharedPracticeSnapshots = runtime.table_from(shared)
    runtime.execute((HERE / 'client_shared_cases.lua').read_text(encoding='utf-8'))
    resources = [runtime.table_from(block.splitlines()) for block in
                 Path(str(wire_path) + '.resources').read_text().strip().split('\n\n')]
    runtime.globals().EncodedResourcePracticeSnapshots = runtime.table_from(resources)
    runtime.execute((HERE / 'client_resource_cases.lua').read_text(encoding='utf-8'))
    runtime.execute((client / 'Transport.lua').read_text(encoding='utf-8'))
    runtime.execute((HERE / 'client_transport_cases.lua').read_text(encoding='utf-8'))


def check_inventory():
    path = ROOT / 'modules/mod-ability-practice/tools/inventory.py'
    spec = importlib.util.spec_from_file_location('practice_inventory', path)
    inventory_module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(inventory_module)
    inventory = inventory_module.build_inventory(ROOT)
    assert inventory['summary']['classCount'] == 21
    assert len(inventory['sources']) == 6
    assert [source['rows'] for source in inventory['sources']] == [847, 2709, 116, 27, 41, 3937]
    assert inventory == inventory_module.build_inventory(ROOT)
    development = (ROOT / 'modules/mod-ability-practice/src/AbilityPracticeDevelopment.h').read_text()
    defined = re.findall(r'AbilityRank\{\s*(\d+),\s*\d+,\s*\{\s*(\d+),\s*\d+\s*\}\s*\}', development)
    assert len(defined) == 27
    source_levels = {row['spellId']: row['reportedLevels'] for row in inventory['spells'] if row['classId'] == 24}
    for spell, level in defined:
        assert int(level) in source_levels[int(spell)]
    for spell in inventory['spells']:
        assert spell['evidence']
        assert 'effective-data-unverified' in spell['reviewFlags']
        assert 'practice-classification-unreviewed' in spell['reviewFlags']
    assert any('tree-acquisition-gate' in spell['reviewFlags'] for spell in inventory['spells'])
    assert any('level-unresolved' in spell['reviewFlags'] for spell in inventory['spells'])
    assert any(row['meaning'] == 'acquisition-reference' for row in inventory['relationships'])
    columns = ('class', 'spell')
    valid = 'inline constexpr std::array<Row, 1> Test = {{ { 12, 100 }, }};'
    assert inventory_module.read_rows(valid, 'Test', columns) == [{'class': 12, 'spell': 100}]
    malformed = [valid.replace('Row, 1', 'Row, 2'), valid.replace('100', 'invalid'),
                 valid.replace('12, 100', '12, 100, 2'), valid.replace('12, 100', '0, 100'),
                 valid + valid, valid.replace('Test', 'Other')]
    for content in malformed:
        try:
            inventory_module.read_rows(content, 'Test', columns)
        except ValueError:
            continue
        raise AssertionError('Malformed inventory source accepted: ' + content)
    sample = {'spells': [
        {'classId': 24, 'spellId': 101, 'reviewFlags': ['effective-data-unverified']},
        {'classId': 24, 'spellId': 102, 'reviewFlags': ['effective-data-unverified']},
        {'classId': 24, 'spellId': 103, 'reviewFlags': ['effective-data-unverified']},
    ], 'summary': {}}
    evidence = {101: {'name': 'Test', 'rankLabel': 'Rank 1', 'passive': True},
                102: {'name': 'Test', 'rankLabel': 'Rank 2', 'passive': False}}
    inventory_module.annotate_dbc(sample, evidence.get, {'manifest_match': False})
    assert sample['spells'][0]['rawRankNumber'] == 1
    assert 'raw-dbc-passive-review' in sample['spells'][0]['reviewFlags']
    assert 'stale-extraction-manifest' in sample['spells'][1]['reviewFlags']
    assert 'missing-raw-dbc-record' in sample['spells'][2]['reviewFlags']
    assert sample['summary']['nameRankCandidateCount'] == 1
    assert sample['summary']['ambiguousNameRankCandidateCount'] == 0
    assert all('effective-data-unverified' in row['reviewFlags'] for row in sample['spells'])
    ambiguous = {'spells': [
        {'classId': 24, 'spellId': 201, 'reviewFlags': []},
        {'classId': 24, 'spellId': 202, 'reviewFlags': []},
        {'classId': 24, 'spellId': 203, 'reviewFlags': []},
    ], 'summary': {}}
    ranks = {201: {'name': 'Test', 'rankLabel': 'Rank 2'},
             202: {'name': 'Test', 'rankLabel': 'Rank 2'},
             203: {'name': 'Test', 'rankLabel': 'Rank 4'}}
    inventory_module.annotate_dbc(ambiguous, ranks.get, {'manifest_match': True})
    assert ambiguous['summary']['ambiguousNameRankCandidateCount'] == 1
    assert set(ambiguous['nameRankCandidates'][0]['reviewFlags']) == {
        'duplicate-raw-rank-number', 'missing-raw-first-rank', 'raw-rank-gap'}
    assert all('ambiguous-name-rank-candidate' in row['reviewFlags'] for row in ambiguous['spells'])
    check_catalog_candidates(inventory)
    sys.path.insert(0, str(ROOT / 'modules/mod-ability-practice/tools'))
    from coverage import declared_profiles, declared_shared_variants
    variants = declared_shared_variants(ROOT, declared_profiles(ROOT))
    assert len(variants) == 34
    assert variants[(31, 582261)]['equivalentSpellId'] == 581315
    assert variants[(31, 582261)]['proficiencyRequired'] == 10
    assert variants[(13, 712458)]['equivalentSpellId'] == 707676
    assert variants[(13, 680872)]['proficiencyRequired'] == 40
    assert variants[(13, 800195)]['parentKind'] == 'fixed'
    assert variants[(21, 523513)]['equivalentSpellId'] == 523493
    assert variants[(21, 523513)]['proficiencyRequired'] == 60
    assert variants[(21, 680294)]['equivalentSpellId'] == 803666
    assert variants[(21, 680294)]['proficiencyRequired'] == 100
    for identity, equivalent, proficiency, level in [
            ((14, 523495), 523483, 80, 60), ((15, 523510), 523488, 40, 60),
            ((29, 803657), 803655, 60, 60), ((15, 680303), 707355, 80, 60),
            ((15, 681442), 707687, 40, 58), ((32, 561241), 561240, 40, 60),
            ((32, 561242), 561236, 1, 52), ((32, 561243), 560295, 1, 54),
            ((28, 680315), 707688, 100, 60), ((28, 803665), 803663, 80, 58), ((31, 570756), 570755, 40, 60),
            ((31, 572817), 572815, 80, 60), ((31, 680310), 573349, 100, 60), ((30, 575842), 575841, 20, 60),
            ((30, 578130), 578129, 40, 60), ((30, 680298), 803314, 80, 60), ((26, 573348), 573345, 20, 56),
            ((26, 680301), 301225, 60, 56), ((16, 575846), 575845, 20, 60),
            ((16, 578316), 578315, 60, 56), ((16, 680291), 503323, 80, 60), ((18, 582536), 582535, 20, 60),
            ((18, 680280), 301232, 80, 60), ((22, 572396), 572395, 60, 58),
            ((22, 680307), 802829, 40, 58), ((27, 575045), 575043, 40, 58),
            ((27, 681160), 300865, 100, 60), ((27, 572390), 572389, 80, 60)]:
        assert variants[identity]['equivalentSpellId'] == equivalent
        assert variants[identity]['proficiencyRequired'] == proficiency
        assert variants[identity]['characterLevel'] == level
    assert variants[(32, 561242)]['parentKind'] == 'fixed'
    assert variants[(32, 561243)]['parentKind'] == 'fixed'
    declarations = declared_profiles(ROOT)
    del declarations[(13, 707671)]
    try:
        declared_shared_variants(ROOT, declarations)
    except ValueError:
        pass
    else:
        raise AssertionError('Shared variant with missing parent accepted')
    print('PASS: deterministic 21-class source inventory, provenance and malformed-source rejection')


def check_catalog_candidates(inventory):
    path = ROOT / 'modules/mod-ability-practice/tools/catalog_candidates.py'
    spec = importlib.util.spec_from_file_location('practice_catalog_candidates', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    before = copy.deepcopy(inventory)
    result = module.build_candidates(inventory)
    assert inventory == before
    assert result == module.build_candidates(inventory)
    assert result['summary']['classCount'] == 21
    assert result['summary']['productionApprovedCount'] == 0
    assert all(row['classification'] == 'pending' and not row['productionApproved'] for row in result['candidates'])
    observed = {(row['classId'], member['spellId']) for row in result['candidates'] for member in row['members']}
    assert observed == {(row['classId'], row['spellId']) for row in inventory['spells']}
    bloodbolt = [804685, 806928, 806929, 806930, 806931, 806932, 578304, 578305]
    missing_leech = [{'classId': 20, 'spellId': spell} for spell in bloodbolt]
    review = module.native_direct_leech_review(missing_leech)
    assert not review['commonRoutes'] and review['blockedMembers']
    malformed_leech = [{**member, 'rawDbc': {'effects': [9, 6, 0], 'effectDetails': []}}
                       for member in missing_leech]
    try:
        module.native_direct_leech_review(malformed_leech)
    except ValueError:
        pass
    else:
        raise AssertionError('Changed reviewed leech shape accepted')
    sample = {'schemaVersion': 1, 'sources': [], 'relationships': [], 'spells': [
        {'classId': 24, 'spellId': spell, 'reportedLevels': [1], 'reviewFlags': [],
         'rawRankNumber': 1, 'rawDbc': {'name': 'Same name'}} for spell in (101, 102, 103)]}
    sample['relationships'] = [{'classId': 24, 'spellId': 103, 'referenceSpellId': 101,
                                'meaning': 'acquisition-reference', 'source': 'captured-offers'}]
    separate = module.build_candidates(sample)
    assert len(separate['candidates']) == 3
    assert all(len(row['members']) == 1 for row in separate['candidates'])
    assert 'external-acquisition-prerequisite' in separate['candidates'][2]['reviewFlags']
    sample['relationships'] += [{'classId': 24, 'spellId': 103, 'referenceSpellId': root,
                                 'meaning': 'claimed-root', 'source': 'generated-progression'} for root in (101, 102)]
    conflicting = module.build_candidates(sample)
    assert len(conflicting['candidates']) == 2
    assert conflicting['summary']['conflictingMembershipCount'] == 2
    assert all('claimed-chain-raw-rank-conflict' in row['reviewFlags'] for row in conflicting['candidates'])
    assert all('shared-reported-levels' in row['reviewFlags'] for row in conflicting['candidates'])
    node = {'id': 7, 'values': {'RequiredLevel': 14, 'RankSpell[0]': 103},
            'scope': 'raw-data-reference-not-character-entitlement'}
    module.annotate_acquisition(conflicting, lambda spell: [node, node] if spell == 103 else [], [])
    assert conflicting['summary']['withRawAcquisitionCount'] == 2
    assert all(len(row['rawAcquisition']) == 1 for row in conflicting['candidates'])
    for row in conflicting['candidates']:
        observed_node = row['rawAcquisition'][0]
        assert {key: value for key, value in observed_node.items() if key != 'nativeLoaderReview'} == node
        assert observed_node['nativeLoaderReview']['status'] == 'missing-or-invalid-class-evidence'
    assert 'nativeLoaderReview' not in node
    assert all('native-acquisition-filtering-unobserved' in row['reviewFlags'] for row in conflicting['candidates'])
    assert all(not row['productionApproved'] and row['classification'] == 'pending'
               for row in conflicting['candidates'])
    module.annotate_acquisition(separate, lambda spell: [], [])
    assert separate['summary']['withRawAcquisitionCount'] == 0
    malformed = copy.deepcopy(sample)
    malformed['spells'].append(copy.deepcopy(malformed['spells'][0]))
    missing = copy.deepcopy(sample)
    missing['spells'].pop()
    unknown = copy.deepcopy(sample)
    unknown['relationships'][0]['meaning'] = 'guessed-root'
    for invalid in (malformed, missing, unknown, {**sample, 'schemaVersion': 2}):
        try:
            module.build_candidates(invalid)
        except ValueError:
            continue
        raise AssertionError('Malformed source candidate inventory accepted')
    print('PASS: all-class source grouping preserves acquisition references, conflicts and pending review')


def check_pacing_generation():
    sys.path.insert(0, str(ROOT / 'modules/mod-ability-practice/tools'))
    from rank_pacing_development import render_header, validate_profile_additions
    text = (ROOT / 'modules/mod-ability-practice/src/AbilityPracticeDevelopmentPacing.h').read_text(encoding='utf-8')
    proposals = []
    for match in re.finditer(r'inline constexpr std::array RanksClass(\d+)Ability(\d+) = \{(.*?)\};',
                            text, re.DOTALL):
        class_id, ability_id = int(match[1]), int(match[2])
        ranks = [dict(zip(('spellId', 'rankNumber', 'characterLevel', 'proficiencyRequired'), map(int, values)))
                 for values in re.findall(r'AbilityRank\{ (\d+), (\d+), \{ (\d+), (\d+) \} \}', match[3])]
        bands = re.search(r'inline constexpr std::array BandsClass' + match[1] + 'Ability' + match[2] +
                          r' = \{(.*?)\};', text, re.DOTALL)
        policy = [dict(zip(('firstProficiency', 'pointsPerLevel', 'pointsPerUse'), map(int, values)))
                  for values in re.findall(r'TrainingBand\{ (\d+), (\d+), (\d+) \}', bands[1])]
        proposals.append({'classId': class_id, 'abilityId': ability_id,
                          'existingDevelopmentDeclaration': {'authoredRanks': ranks}, 'proposedTrainingBands': policy})
    before = copy.deepcopy(proposals)
    reproduced, _ = render_header({'proposals': list(reversed(proposals))}, ROOT, 2, len(proposals), text)
    assert reproduced == text and proposals == before
    scaled = copy.deepcopy(proposals)
    for value in scaled:
        for band in value['proposedTrainingBands']:
            band['pointsPerLevel'] *= 2
            band['pointsPerUse'] *= 2
    reproduced, _ = render_header({'proposals': scaled}, ROOT, 2, len(proposals), text)
    assert reproduced == text
    invalid = copy.deepcopy(scaled)
    invalid[0]['proposedTrainingBands'][0]['pointsPerLevel'] = 0
    invalid[0]['proposedTrainingBands'][0]['pointsPerUse'] = 0
    try:
        render_header({'proposals': invalid}, ROOT, 2, len(proposals), text)
    except ValueError:
        pass
    else:
        raise AssertionError('Equivalent-scale preservation accepted an invalid zero-rate proposal')
    added = {'classId': 31, 'abilityId': 9000001,
             'existingDevelopmentDeclaration': {'authoredRanks': [
                 {'spellId': 9000001, 'rankNumber': 1, 'characterLevel': 44, 'proficiencyRequired': 1},
                 {'spellId': 9000002, 'rankNumber': 2, 'characterLevel': 60, 'proficiencyRequired': 10}]},
             'proposedTrainingBands': [{'firstProficiency': 1, 'pointsPerLevel': 16200, 'pointsPerUse': 270}]}
    expanded = {'proposals': [added, *reversed(proposals)]}
    assert validate_profile_additions(expanded, ROOT, 2, text) == 1
    generated, summary = render_header(expanded, ROOT, 2, len(proposals) + 1, text)
    assert summary['profileCount'] == len(proposals) + 1 and 'RanksClass31Ability9000001' in generated
    for field in ('pointsPerUse', 'pointsPerLevel'):
        changed = copy.deepcopy(expanded)
        changed['proposals'][1]['proposedTrainingBands'][0][field] += 30
        try:
            validate_profile_additions(changed, ROOT, 2, text)
        except ValueError:
            pass
        else:
            raise AssertionError('Additive expansion changed existing pacing: ' + field)
    changed = copy.deepcopy(expanded)
    changed['proposals'][1]['existingDevelopmentDeclaration']['authoredRanks'][0]['characterLevel'] += 1
    try:
        validate_profile_additions(changed, ROOT, 2, text)
    except ValueError:
        pass
    else:
        raise AssertionError('Additive expansion changed existing ranks')
    print('PASS: pacing generator preserves independent declaration/entry order and rejects changed prior curves')


def main():
    check_inventory()
    check_pacing_generation()
    compiler = shutil.which(os.environ.get('CXX', 'cl.exe' if os.name == 'nt' else 'c++'))
    if not compiler:
        raise RuntimeError('Enable a C++20 compiler for the isolated ability practice harness.')
    with tempfile.TemporaryDirectory(prefix='coa-ability-practice-') as directory:
        output = Path(directory)
        executable = output / ('practice.exe' if os.name == 'nt' else 'practice')
        include = ROOT / 'modules/mod-ability-practice/src'
        source = HERE / 'harness.cpp'
        if Path(compiler).stem.lower() == 'cl':
            flags = ['/nologo', '/std:c++20', '/EHsc', '/W4', '/WX', '/utf-8', '/I' + str(include),
                     str(source), '/Fe' + str(executable)]
        else:
            flags = ['-std=c++20', '-Wall', '-Wextra', '-Werror', '-pthread', '-I' + str(include),
                     str(source), '-o', str(executable)]
        subprocess.run([compiler, *flags], cwd=output, check=True, timeout=60)
        wire = output / 'menu-wire.txt'
        subprocess.run([str(executable), str(wire)], cwd=output, check=True, timeout=30)
        check_client(wire)


if __name__ == '__main__':
    main()
