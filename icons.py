from bflib import *

from PIL import Image
from PIL import ImageDraw

MULTIPLIER = 3
DIM = ICON_SIZE * MULTIPLIER
DIMS = (DIM, DIM)
TRANSPARENT = (255, 255, 255, 0)
LINK_FG = (0, 0, 255, 255)
LINK_BG = (255, 255, 255, 255)

def build_download_icon():
    image = Image.new('RGBA', DIMS, color=TRANSPARENT)
    draw = ImageDraw.Draw(image)

    draw.rounded_rectangle((0, 0, DIM - 1, DIM - 1),
        fill=LINK_BG, outline=LINK_FG, radius=DIM, width = 3)

    # Define the arrow parameters
    arrow_width = 9
    arrow_length = 36
    arrow_head_length = 27
    arrow_color = LINK_FG

    # Coordinates for the arrow shaft
    shaft_x1 = DIM // 2
    shaft_y1 = 16
    shaft_x2 = DIM // 2
    shaft_y2 = shaft_y1 + arrow_length

    # Draw the arrow shaft (a thick line)
    draw.line([(shaft_x1, shaft_y1), (shaft_x2, shaft_y2)], fill=arrow_color, width=arrow_width)

    # Coordinates for the arrow head
    head_left_x = shaft_x2 - arrow_head_length // 2
    head_left_y = shaft_y2
    head_right_x = shaft_x2 + arrow_head_length // 2
    head_right_y = shaft_y2
    head_bottom_x = shaft_x2
    head_bottom_y = shaft_y2 + arrow_head_length

    # Draw the arrow head (a filled triangle)
    draw.polygon([(head_left_x - 4, head_left_y), (head_right_x + 4, head_right_y), (head_bottom_x, head_bottom_y)], fill=arrow_color)
    path = f'{OUTPUT_PATH}/download.png'
    image = image.resize((ICON_SIZE, ICON_SIZE), resample=Image.Resampling.BICUBIC)
    image.save(path, 'PNG')
    print(f'Added {path}')

if __name__ == '__main__':
    build_download_icon()