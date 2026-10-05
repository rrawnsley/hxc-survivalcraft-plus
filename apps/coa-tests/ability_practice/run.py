import os
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
    print('PASS: deterministic 21-class source inventory, provenance and malformed-source rejection')


def main():
    check_inventory()
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
            flags = ['-std=c++20', '-Wall', '-Wextra', '-Werror', '-I' + str(include),
                     str(source), '-o', str(executable)]
        subprocess.run([compiler, *flags], cwd=output, check=True, timeout=60)
        wire = output / 'menu-wire.txt'
        subprocess.run([str(executable), str(wire)], cwd=output, check=True, timeout=30)
        check_client(wire)


if __name__ == '__main__':
    main()
