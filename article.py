from bflib import build_page
from pathlib import Path
from mako.lookup import TemplateLookup

import sys

def build_article(lookup: TemplateLookup, name: str):
    build_page(lookup, name, Path(name))

if __name__ == '__main__':
    name = sys.argv[1]
    lookup = TemplateLookup(
        directories=['article', 'template'],
        output_encoding='utf-8',
        encoding_errors='replace')

    build_article(lookup, name)