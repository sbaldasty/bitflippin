from bflib import *

from pygments.formatters import HtmlFormatter
from pygments.styles import get_style_by_name

def build_codesnippet_styles():
    path = OUTPUT_PATH.joinpath('codesnippets.css')
    style = get_style_by_name('zenburn')
    css = HtmlFormatter(style=style).get_style_defs('.highlight')
    path.write_text(css)

    print(f'Added {path}')

if __name__ == '__main__':
    build_codesnippet_styles()