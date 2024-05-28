import glob
import shutil

from bflib import OUTPUT_PATH

def build_downloads():
    path = OUTPUT_PATH.joinpath('download')
    path.mkdir(parents=True, exist_ok=True)
    # TODO Do this with pathlib?
    for file in glob.glob(r'download/*'):
        shutil.copy(file, 'out/download')
        filename = file[file.index('/'):]
        print(f'Added out{filename}')

if __name__ == '__main__':
    build_downloads()