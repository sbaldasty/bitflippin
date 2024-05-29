<%def name="codesnippet(lang)">
    <%
        from pygments import highlight
        from pygments.lexers.special import TextLexer
        from pygments.formatters import HtmlFormatter

        body = capture(caller.body)
    %>
    ${highlight(body.strip(), TextLexer(), HtmlFormatter())}
</%def>

<%def name="download(file)">
    <%
        import humanize
        from bflib import ICON_SIZE, OUTPUT_PATH
        from pathlib import Path

        body = capture(caller.body)
        file_size = Path(f'download/{file}').stat().st_size
        human_readable_size = humanize.naturalsize(file_size, binary=True)
    %>
    <a class="download" href="/download/${file}" download>
    <div class="description">${body}</div>
    <div class="file">
    <div class="name">${file}</div>
    <div class="size">${human_readable_size}</div>
    </div>
    <div class="icon">
    <img alt="Download" height="${ICON_SIZE}px" src="/download.png" title="Download" width="${ICON_SIZE}px">
    </div>
    </a>
</%def>

<%def name="gallery(fn, fid, x, y, width, angle)">
    <%
        from bflib import build_image, camera_resource
        from bflib import PHOTO_HEIGHT, PHOTO_WIDTH
        from pathlib import Path

        src = camera_resource(fid)
        dest = Path(f'photo/{fn}.jpg')
        build_image(dest, src, int(x), int(y), int(width), int(angle), PHOTO_WIDTH, PHOTO_HEIGHT)
    %>
    <div class="gallery">
    <img alt="${caller.title()}" height="${PHOTO_HEIGHT}px" src="/photo/${fn}.jpg" title="${caller.title()}" width="${PHOTO_WIDTH}px">
    <div class="expo">
    <div class="title">${caller.title()}</div>
    <div>${caller.caption()}</div>
    </div>
    </div>
</%def>

<%def name="gap()">
    <div class="gap"></div>
</%def>

<%def name="headline(aid)">
    <%
        from mako.lookup import TemplateLookup

        lookup = TemplateLookup(
            directories=['article', 'template'],
            output_encoding='utf-8',
            encoding_errors='replace')
        
        template = lookup.get_template(f'{aid}.mako')
    %>
    <div class="headline">
    <div class="title">
    <a href="${aid}">${template.module.title_}</a>
    </div>
    <div>${capture(caller.body)}</div>
    </div>
</%def>