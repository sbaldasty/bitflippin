<%def name="gallery(fn, fid, x, y, width, angle)">
    <%
        from bflib import build_image, camera_resource
        from bflib import PHOTO_HEIGHT, PHOTO_WIDTH
        from pathlib import Path

        src = camera_resource(fid)
        base = Path('out/_photo')
        base.mkdir(parents=True, exist_ok=True)
        dest = base.joinpath(f'{fn}.jpg')
        build_image(dest, src, int(x), int(y), int(width), int(angle), PHOTO_WIDTH, PHOTO_HEIGHT)
    %>
    <div class="gallery">
    <img alt="${caller.title()}" height="${PHOTO_HEIGHT}px" src="/_photo/${fn}.jpg" title="${caller.title()}" width="${PHOTO_WIDTH}px">
    <div class="expo">
    <div class="title">${caller.title()}</div>
    <div>${caller.caption()}</div>
    </div>
    </div>
</%def>