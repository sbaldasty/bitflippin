from bflib import *

from pygments.formatters import HtmlFormatter

def build_codesnippet_styles():
    path = OUTPUT_PATH.joinpath('codesnippets.css')
    styles = HtmlFormatter().get_style_defs('.highlight')
    path.write_text(styles)

    print(f'Added {path}')

if __name__ == '__main__':
    build_codesnippet_styles()