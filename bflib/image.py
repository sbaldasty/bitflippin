from PIL import Image
from pathlib import Path

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