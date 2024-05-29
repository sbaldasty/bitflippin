from bflib import *

from PIL import Image
from PIL import ImageDraw

TRANSPARENT = (255, 255, 255, 0)
LINK_FG = (0, 0, 255, 255)
LINK_BG = (255, 255, 255, 255)

def build_download_icon():
    image = Image.new('RGBA', (ICON_SIZE, ICON_SIZE), color=TRANSPARENT)
    draw = ImageDraw.Draw(image)

    draw.rounded_rectangle((0, 0, ICON_SIZE - 1, ICON_SIZE - 1),
        fill=LINK_BG, outline=LINK_FG, radius=ICON_SIZE, width = 2)

    # Define the arrow parameters
    arrow_width = 3
    arrow_length = 12
    arrow_head_length = 9
    arrow_color = LINK_FG

    # Coordinates for the arrow shaft
    shaft_x1 = ICON_SIZE // 2
    shaft_y1 = 6
    shaft_x2 = ICON_SIZE // 2
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
    draw.polygon([(head_left_x, head_left_y), (head_right_x, head_right_y), (head_bottom_x, head_bottom_y)], fill=arrow_color)
    path = f'{OUTPUT_PATH}/download.png'
    image.save(path, 'PNG')
    print(f'Added {path}')

if __name__ == '__main__':
    build_download_icon()