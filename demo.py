from mako.template import Template
from mako.lookup import TemplateLookup
from pathlib import Path

mylookup = TemplateLookup(directories=['content', 'template'], output_encoding='utf-8', encoding_errors='replace')

mytemplate = mylookup.get_template("hello.mako")
Path('out').mkdir(parents=True, exist_ok=True)
Path('out/demo.html').write_bytes(mytemplate.render())