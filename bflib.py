import htmlmin

from PIL import Image
from pathlib import Path
from mako.lookup import Template
from mako.lookup import TemplateLookup

HEADSHOT_WIDTH = 86
HEADSHOT_HEIGHT = 86
PHOTO_WIDTH = 140
PHOTO_HEIGHT = 105

CAMERA_PATH = Path.home().joinpath('CAMERA')
OUTPUT_PATH = Path('out')

def camera_resource(id: str):
    return CAMERA_PATH.joinpath(f'{id}.JPG')

def build_image(
        outpath: Path, inpath: Path,
        x: int, y: int, width: int, angle: int,
        trg_width: int, trg_height: int):

    image = Image.open(inpath)
    image = image.rotate(angle, expand=True)
    image = image.crop((x, y, x + width, y + width * trg_height / trg_width))
    image = image.resize((trg_width, trg_height))
    outpath = OUTPUT_PATH.joinpath(outpath)
    outpath.parent.mkdir(parents=True, exist_ok=True)
    image.save(outpath, quality=75)
    print(f'Added {outpath}')

def build_page(lookup: TemplateLookup, name: str, path: Path):
    template: Template = lookup.get_template(f'{name}.mako')
    path = OUTPUT_PATH.joinpath(path)
    path.mkdir(parents=True, exist_ok=True)
    path = path.joinpath('index.html')
    html = template.render().decode('utf-8')

    path.write_text(htmlmin.minify(html,
            remove_comments=True,
            remove_all_empty_space=True))

    print(f'Added {path}')