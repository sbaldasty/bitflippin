from PIL import Image
from pathlib import Path

HEADSHOT_WIDTH = 86
HEADSHOT_HEIGHT = 86
PHOTO_WIDTH = 140
PHOTO_HEIGHT = 105

def camera_resource(id: str):
    return Path.home().joinpath(f'CAMERA/{id}.JPG')

def build_image(
        outpath: Path, inpath: Path,
        x: int, y: int, width: int, angle: int,
        trg_width: int, trg_height: int):

    image = Image.open(inpath)
    image = image.rotate(angle, expand=True)
    image = image.crop((x, y, x + width, y + width * trg_height / trg_width))
    image = image.resize((trg_width, trg_height))
    image.save(outpath, quality=75)

    print(f'Added {outpath}')

def build_photo(name: str, id: str, x: int, y: int, width: int, angle: int):
    src = camera_resource(id)
    base = Path('out/_photo')
    base.mkdir(parents=True, exist_ok=True)
    dest = base.joinpath(f'{name}.jpg')
    build_image(dest, src, x, y, width, angle, PHOTO_WIDTH, PHOTO_HEIGHT)