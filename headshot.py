from pathlib import Path
from bflib.image import build_image

WIDTH = 86
HEIGHT = 86

def build_headshot():
    src = Path.home().joinpath('CAMERA/00000000.JPG')
    dest = Path('out/headshot.jpg')
    build_image(dest, src, 0, 20, 328, 0, WIDTH, HEIGHT)

if __name__ == '__main__':
    build_headshot()