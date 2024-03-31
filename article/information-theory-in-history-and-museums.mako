<%!
    title_ = 'Information theory in history and museums'
    date_ = '2023-08-09'
    enable_gallery_ = True
%>
<%inherit file="article.mako" />
<%namespace name="gallery" file="gallery.mako" />
<%block name="article">
    <p>asdf content!</p>
    <%gallery:gallery fn="campus-at-dusk" fid="00000001" x="200" y="0" width="2900" angle="0">
        <%def name="title()">My Title 1</%def>
        <%def name="caption()">
            My caption 1
        </%def>
    </%gallery:gallery>
    <%gallery:gallery fn="information-theory-textbook" fid="00000002" x="400" y="500" width="1000" angle="0">
        <%def name="title()">My Title 2</%def>
        <%def name="caption()">
            My caption 2
        </%def>
    </%gallery:gallery>
</%block>