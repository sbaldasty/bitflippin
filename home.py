from mako.lookup import TemplateLookup
from pathlib import Path

def build_home(lookup: TemplateLookup):
    template = lookup.get_template('home.mako')
    base = Path(f'out')
    base.mkdir(parents=True, exist_ok=True)
    path = base.joinpath('index.html')
    path.write_bytes(template.render(name='home.html'))
    print(f'Added {path}')

if __name__ == '__main__':
    lookup = TemplateLookup(
        directories=['standalone', 'template'],
        output_encoding='utf-8',
        encoding_errors='replace')

    build_home(lookup)