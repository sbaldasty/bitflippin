from pathlib import Path
from bflib.image import *

def build_headshot():
    src = camera_resource('00000000')
    dest = Path('out/headshot.jpg')
    build_image(dest, src, 0, 20, 328, 0, HEADSHOT_WIDTH, HEADSHOT_HEIGHT)

if __name__ == '__main__':
    build_headshot()