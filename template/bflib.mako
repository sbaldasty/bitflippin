<%def name="codesnippet(lang)">
    <%
        from pygments import highlight
        from pygments.lexers import BashLexer
        from pygments.formatters import HtmlFormatter

        body = capture(caller.body)
    %>
    ${highlight(body.strip(), BashLexer(), HtmlFormatter())}
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