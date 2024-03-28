import glob
import shutil

def build_static_assets():
    for file in glob.glob(r'static/*'):
        shutil.copy(file, 'out')
        print(f'Added /out/{file}')

if __name__ == '__main__':
    build_static_assets()