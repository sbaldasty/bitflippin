<%def name="gallery(fn, fid, x, y, width, angle)">
    <%
        from bflib.image import build_photo
        from bflib.image import PHOTO_HEIGHT
        from bflib.image import PHOTO_WIDTH
        build_photo(fn, fid, int(x), int(y), int(width), int(angle))
    %>
    <div class="gallery">
    <img style="" alt="${caller.title()}" height="${PHOTO_HEIGHT}px" src="/_photo/${fn}.jpg" title="${caller.title()}" width="${PHOTO_WIDTH}px">
    <div class="expo">
    <div class="title">${caller.title()}</div>
    <div>${caller.caption()}</div>
    </div>
    </div>
</%def>