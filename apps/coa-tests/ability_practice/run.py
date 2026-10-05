import os
from pathlib import Path
import shutil
import subprocess
import tempfile


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def main():
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
        subprocess.run([str(executable)], cwd=output, check=True, timeout=30)


if __name__ == '__main__':
    main()
