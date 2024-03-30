from mako.lookup import TemplateLookup
from pathlib import Path

import sys

def build_article(lookup: TemplateLookup, name: str):
    template = lookup.get_template(f'{name}.mako')
    base = Path(f'out/{name}')
    base.mkdir(parents=True, exist_ok=True)
    path = base.joinpath('index.html')
    path.write_bytes(template.render())
    print(f'Added {path}')

if __name__ == '__main__':
    name = sys.argv[1]
    lookup = TemplateLookup(
        directories=['article', 'template'],
        output_encoding='utf-8',
        encoding_errors='replace')

    build_article(lookup, name)