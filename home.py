from bflib import build_page
from mako.lookup import TemplateLookup
from pathlib import Path

def build_home(lookup: TemplateLookup):
    build_page(lookup, 'home', Path())

if __name__ == '__main__':
    lookup = TemplateLookup(
        directories=['standalone', 'template'],
        output_encoding='utf-8',
        encoding_errors='replace')

    build_home(lookup)