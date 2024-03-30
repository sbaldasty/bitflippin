import glob
import shutil

def build_static_assets():
    # TODO Do this with pathlib?
    for file in glob.glob(r'static/*'):
        shutil.copy(file, 'out')
        filename = file[file.index('/'):]
        print(f'Added out{filename}')

if __name__ == '__main__':
    build_static_assets()