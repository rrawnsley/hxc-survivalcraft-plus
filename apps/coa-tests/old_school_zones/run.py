import os
from pathlib import Path
import runpy
import shutil
import subprocess
import tempfile


ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
METHOD = runpy.run_path(str(HERE.parent / 'client_compat/run.py'))['method']


def main():
    source = (ROOT / 'modules/mod-coa-challenges/src/CoA.Challenges.Scripts.cpp').read_text()
    signatures = (
        'uint32 OldSchoolChallenge(Player const* player)\n    {',
        'bool OldSchoolCreature(',
        'struct OldSchoolPowerProfile',
        'bool IsOldSchoolMulgoreNamedThreat(',
        'bool IsOldSchoolBarrensNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolStonetalonNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolAshenvaleNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolSouthernNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolTirisfalNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolSilverpineNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolHillsbradNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolArathiNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolHinterlandsNamedThreat(Creature const* creature)\n    {',
        'bool IsOldSchoolPlaguelandsNamedThreat(Creature const* creature)\n    {',
        'int32 OldSchoolNamedThreatOffset(Creature const* creature)\n    {',
        'uint32 OldSchoolNamedRewardHundredths(Creature const* creature)\n    {',
        'struct OldSchoolCampThreat',
        'OldSchoolCampThreat GetOldSchoolCampThreat(',
        'bool IsOldSchoolSameCamp(',
        'uint32 CountOldSchoolCampmates(',
        'int32 OldSchoolThreatOffset(',
        'int32 OldSchoolThreatLevel(',
        'OldSchoolPowerProfile GetOldSchoolEncounterPower(',
        'OldSchoolPowerProfile GetOldSchoolPowerProfile(',
        'uint32 OldSchoolExperienceSourceMultiplier(',
        'char const* OldSchoolConColor(',
        'uint32 OldSchoolGroupBonusPercent(',
    )
    assert 'CallForHelp(' not in source, 'Old School must preserve native creature assistance behavior'
    methods = '\n'.join(METHOD(source, signature).replace(' override', '')
                        + (';' if signature.startswith('struct ') else '') for signature in signatures)
    code = (HERE / 'harness.cpp').read_text().replace('// NATIVE_METHODS', methods)
    compiler = shutil.which(os.environ.get('CXX', 'cl.exe' if os.name == 'nt' else 'c++'))
    assert compiler, 'A C++20 compiler is required'
    with tempfile.TemporaryDirectory(prefix='coa-old-school-zones-') as directory:
        out = Path(directory)
        (out / 'Define.h').write_text('#pragma once\n#include <cstdint>\n'
                                    'using uint32 = std::uint32_t;\n'
                                    'using uint64 = std::uint64_t;\n'
                                    'using int32 = std::int32_t;\n')
        target = out / 'harness.cpp'
        target.write_text(code)
        executable = out / ('harness.exe' if os.name == 'nt' else 'harness')
        includes = [out, ROOT / 'src/server/game/Maps', ROOT / 'modules/mod-coa-challenges/src']
        if Path(compiler).stem.lower() == 'cl':
            flags = ['/nologo', '/std:c++20', '/EHsc', '/W4', '/WX', '/utf-8']
            flags += ['/I' + str(path) for path in includes]
            flags += [str(target), '/Fe' + str(executable)]
        else:
            flags = ['-std=c++20', '-Wall', '-Wextra', '-Werror']
            flags += [flag for path in includes for flag in ('-I', str(path))]
            flags += [str(target), '-o', str(executable)]
        subprocess.run([compiler, *flags], cwd=out, check=True, timeout=120)
        subprocess.run([str(executable)], check=True, timeout=30)
    print('PASS: Native Old School zone threat profiles; creature assistance behavior is unchanged')


if __name__ == '__main__':
    main()
