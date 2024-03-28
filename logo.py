from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont

TRANSPARENT = (255, 255, 255, 0)
BOX_COLOR = (77, 185, 240, 255)
BOX_SPACING = 5
BOX_SIZE = 40
FONT_SIZE = 30
TRIM_COLOR = (0, 0, 0, 255)

def build_site_logo():
    size = 2 * BOX_SIZE + BOX_SPACING + 1
    indent = BOX_SIZE + BOX_SPACING
    image = Image.new('RGBA', (size, size), color=TRANSPARENT)
    bigger_font = ImageFont.load_default(size=FONT_SIZE)
    draw = ImageDraw.Draw(image)
    blocks = (('1', indent, 0), ('1', 0, indent), ('0', indent, indent))

    for content, x, y in blocks:
        draw.rectangle((x, y, x + BOX_SIZE, y + BOX_SIZE),
            fill=BOX_COLOR,
            outline=TRIM_COLOR)

        draw.text((x + 12, y + 2), content,
            fill=TRIM_COLOR,
            font=bigger_font)

    path = 'out/logo.png'
    image.save(path, 'PNG')
    print(f'Added {path}')

if __name__ == '__main__':
    build_site_logo()