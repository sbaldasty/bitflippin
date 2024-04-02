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
    <%gallery:gallery fn="ancient-chinese-printing" fid="00000007" x="500" y="1450" width="500" angle="0">
        <%def name="title()">Ancient Chinese printing technology</%def>
        <%def name="caption()">Symbols were selected from this wheel and used in something like a printing press. This technology predated the European printing press, but it was tightly controlled by the government and never spread widely.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="bible-page-1830" fid="00000008" x="500" y="1300" width="800" angle="0">
        <%def name="title()">Bible page from 1830</%def>
        <%def name="caption()">Bibles were an early priority for the printing press during the Protestant revolution and beyond. They played an important role in European and American society, and continue to play an important role for many today.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="colored-bible-illustration" fid="00000009" x="550" y="0" width="3400" angle="-90">
        <%def name="title()">Colored illustration from a Bible</%def>
        <%def name="caption()">Many painstakingly colored illustrations from very old Bibles were on display here. I wish I understood the significance of the details in these illustrations better than I do.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="early-color-printer" fid="00000010" x="0" y="400" width="2600" angle="0">
        <%def name="title()">Early color printer</%def>
        <%def name="caption()">This was one of the earlier electronic machines that could print in color at scale. The more modern machines displayed nearby illustrate the miniaturization this technology underwent.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="old-computers" fid="00000011" x="1150" y="1000" width="1400" angle="-3">
        <%def name="title()">Old computers</%def>
        <%def name="caption()">These memorable artifacts from my living past mark the beginning of an era of alternatives to printing text. My fascination with them also set the trajectory of my career path.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="ornate-printing-press" fid="00000012" x="500" y="1450" width="2000" angle="-2">
        <%def name="title()">Ornate printing press</%def>
        <%def name="caption()">This massive ornate printing press near the entryway had a golden American Eagle at the top. It was among the most visually striking printing presses on display.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="printing-my-name" fid="00000013" x="0" y="300" width="3000" angle="0">
        <%def name="title()">Printing my name</%def>
        <%def name="caption()">In a hands-on demo, we filled this mold with molten metal to create a stamp for printing my name. Whole pages of text were created this way, and the stamps recycled by melting them again.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="typewriters" fid="00000014" x="100" y="300" width="2600" angle="0">
        <%def name="title()">Typewriters</%def>
        <%def name="caption()">My parents posing near a wall of typewriters similar to the one I used in childhood to type papers for school. I remember the smell of the ink, the feel of the keys, and fixing errors with the eraser of a pencil.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="another-printing-press" fid="00000022" x="100" y="300" width="2600" angle="0">
        <%def name="title()">asdf</%def>
        <%def name="caption()">asdf</%def>
    </%gallery:gallery>
    <p>asdf telephones!</p>
    <%gallery:gallery fn="telegraph-demo" fid="00000015" x="300" y="300" width="3400" angle="0">
        <%def name="title()">Telegraph</%def>
        <%def name="caption()">Before telephones, there were telegraphs. Operators used a key to tap out messages. Visitors to the museum could tap out messages of their own between two such telegraphs.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="older-telephone" fid="00000016" x="1100" y="1500" width="900" angle="-1">
        <%def name="title()">Older telephone</%def>
        <%def name="caption()">The museum had many telephones on display, from the oldest originals to the more modern, in a series of progressions.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="manual-switchboard" fid="00000017" x="800" y="900" width="1300" angle="-1">
        <%def name="title()">Manual switchboard</%def>
        <%def name="caption()">An overwhelmed overworked operator would route and manage calls by plugging cables into this switchboard. The switchboard had indicators to show when lines were no longer in use or the paid time had expired.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="telephone-cable-cross-section" fid="00000018" x="400" y="800" width="2100" angle="0">
        <%def name="title()">Telephone cable cross section</%def>
        <%def name="caption()">Just imagine the many conversations happening side by side along these wires, and the sheer weight of it all.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="undersea-telephone-cable" fid="00000019" x="1400" y="0" width="2500" angle="0">
        <%def name="title()">Undersea telephone cable</%def>
        <%def name="caption()">To connect continents, telephone cables had to be routed under the ocean. Many extra layers helped the cables survive and operate in the harsh undersea environment.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="automated-switchboard" fid="00000020" x="1600" y="1750" width="500" angle="-3">
        <%def name="title()">Automated switchboard</%def>
        <%def name="caption()">Automated mechanical switchboards eventually replaced manual ones. I never fully understood how it worked, but this switchboard could route calls between two actual phones in the exhibit!</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="newer-telephone" fid="00000021" x="500" y="1450" width="2400" angle="0">
        <%def name="title()">Newer telephone</%def>
        <%def name="caption()">This more modern telephone is similar to those I used growing up. Users had to spin the dial for each digit in the number they wanted to call, and when they released it, the phone sent a different number of clicks over the line.</%def>
    </%gallery:gallery>
    <%gallery:gallery fn="outside-telephone-museum" fid="00000023" x="100" y="0" width="3700" angle="0">
        <%def name="title()">Outside the museum</%def>
        <%def name="caption()">asdf</%def>
    </%gallery:gallery>
</%block>