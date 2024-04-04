<%def name="gallery(fn, fid, x, y, width, angle)">
    <%
        from bflib import build_photo
        from bflib import PHOTO_HEIGHT
        from bflib import PHOTO_WIDTH
        build_photo(fn, fid, int(x), int(y), int(width), int(angle))
    %>
    <div class="gallery">
    <img alt="${caller.title()}" height="${PHOTO_HEIGHT}px" src="/_photo/${fn}.jpg" title="${caller.title()}" width="${PHOTO_WIDTH}px">
    <div class="expo">
    <div class="title">${caller.title()}</div>
    <div>${caller.caption()}</div>
    </div>
    </div>
</%def>