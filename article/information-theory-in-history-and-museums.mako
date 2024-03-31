<%!
    title_ = 'Information theory in history and museums'
    date_ = '2023-08-09'
    enable_gallery_ = True
%>
<%inherit file="article.mako" />
<%namespace name="gallery" file="gallery.mako" />
<%block name="article">
    <p>asdf history!</p>
    <%gallery:gallery fn="campus-at-dusk" fid="00000001" x="200" y="0" width="2900" angle="0">
        <%def name="title()">UVM campus at dusk</%def>
        <%def name="caption()">Black ghostlike statues glide across the courtyard just before sunset, around when I stopped working and started graduate school. Students hang cozy hammocks between these trees in warmer weather.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="information-theory-textbook" fid="00000002" x="400" y="500" width="1000" angle="0">
        <%def name="title()">Information theory textbook</%def>
        <%def name="caption()">My caption 1</%def>
    </%gallery:gallery>
    <p>asdf printing!</p>
    <p>asdf telephones!</p>
</%block>