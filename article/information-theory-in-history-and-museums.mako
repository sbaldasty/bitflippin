<%!
    title_ = 'Information theory in history and museums'
    date_ = '2023-08-09'
    enable_gallery_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">
    <p>Information Theory was one of the first <a href="https://www.uvm.edu/courses/ee_272">classes</a> I took at the University of Vermont. It was about thinking of information as bits and, taking out of the picture any meaning the bits might have, considering how to measure the quantity of the information, how to store or transmit it efficiently, and how to do so with redundancy in a way that protects it from corruption from noise.</p>
    <h2>The history of humans and information</h2>
    <p>The class was mostly technical and math oriented. It covered <a href="https://en.wikipedia.org/wiki/Entropy_(information_theory)">entropy</a> and related ideas. However its supplementary readings included a phenomenal less technical <a href="https://www.amazon.com/Information-History-Theory-Flood/dp/1400096235">book</a> called <i>The Information: A History, A Theory, A Flood</i> by James Gleik. The book tells the story of humanity's rapidly quickening dance with information, with countless anecdotes, from ancient history to the present day. Each step brought profound societal changes, and affected the thinking of everyday people in big ways. A few of my favorites were</p>
    <ul>
    <li><p>How in Africa, drums using two pitches could spread news between villages. African drumming was for centuries a long-unparalleled means of communication over enormous distances.</p>
    <li><p>How writing emerged from ancient spoken language and made it possible for information to pass unaltered through space and time.</p>
    <li><p>How in the American West during the early days of telephony, landowners formed a large improvised telephone network through the barbed wire of their fences.</p>
    <li><p>How Robert Cawdrey compiled the first English dictionary, and communicated the notion of what a dictionary even is to the public.</p>
    <li><p>How before people harnessed electricity, Charles Babbage designed a mechanical general purpose computer; and how his collaborator Ada Lovelace worked out how to solve problems with his imaginary computer, and is widely considered the very first computer programmer.</p>
    <li><p>How Claude Shannon and other brilliant thinkers like Andrei Kolmogorov formalized information theory, and laid the foundations for modern electronic communication.</p>
    </ul>
    <p>Among the final ideas presented in the book is that when information is scarce and difficult to access it is expensive; but when information is plentiful and easy to access then attention is expensive. I wonder here at the cusp of what seems to be real artificial intelligence in what novel ways generations after us will relate to information.</p>
    <%bflib:gallery fn="campus-at-dusk" fid="00000001" x="200" y="0" width="2900" angle="0">
        <%def name="title()">UVM campus at dusk</%def>
        <%def name="caption()">Black ghostlike statues glide across the courtyard just before sunset, around when I stopped working and started graduate school. Students hang cozy hammocks between these trees in warmer weather.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="information-theory-textbook" fid="00000002" x="400" y="500" width="1000" angle="0">
        <%def name="title()">Information theory textbook</%def>
        <%def name="caption()">My caption 1</%def>
    </%bflib:gallery>
    <h2>Visiting the Museum of Printing</h2>
    <p>On a recent visit with my parents, we visited the <a href="https://museumofprinting.org/">Museum of Printing</a>. Like the New Hampshire Telephone Museum <a href="/nh-telephone-museum/">described earlier</a>, the exhibits here dovetailed very nicely with the <a href="https://www.amazon.com/Information-History-Theory-Flood/dp/1400096235">book</a> <i>The Information: A History, A Theory, A Flood</i>. From its About Page,</p>
    <blockquote>The Museum of Printing is dedicated to preserving the rich history of the graphic arts, printing and typesetting technology, and printing craftsmanship. In addition to many special collections and small exhibits, the Museum contains hundreds of antique printing, typesetting, and bindery machines, as well as a library of books and printing-related documents.</blockquote>
    <p>I highly recommend visiting this museum for its fascinating hands-on exhibits and the friendly knowledgeable staff who gladly answer questions and offer guided tours. The kinds of artifacts on display and the explanations accompanying them run both broad and deep. Someone even walked me through the process of making a cast of my name from molten metal in the same way an operator would prepare a page for mass production. Afterward they could melt it down again and repeat, but I got to keep mine!</p>
    <%bflib:gallery fn="ancient-chinese-printing" fid="00000007" x="500" y="1450" width="500" angle="0">
        <%def name="title()">Ancient Chinese printing technology</%def>
        <%def name="caption()">Symbols were selected from this wheel and used in something like a printing press. This technology predated the European printing press, but it was tightly controlled by the government and never spread widely.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="bible-page-1830" fid="00000008" x="500" y="1300" width="800" angle="0">
        <%def name="title()">Bible page from 1830</%def>
        <%def name="caption()">Bibles were an early priority for the printing press during the Protestant revolution and beyond. They played an important role in European and American society, and continue to play an important role for many today.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="colored-bible-illustration" fid="00000009" x="550" y="0" width="3400" angle="-90">
        <%def name="title()">Colored illustration from a Bible</%def>
        <%def name="caption()">Many painstakingly colored illustrations from very old Bibles were on display here. I wish I understood the significance of the details in these illustrations better than I do.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="early-color-printer" fid="00000010" x="0" y="400" width="2600" angle="0">
        <%def name="title()">Early color printer</%def>
        <%def name="caption()">This was one of the earlier electronic machines that could print in color at scale. The more modern machines displayed nearby illustrate the miniaturization this technology underwent.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="old-computers" fid="00000011" x="1150" y="1000" width="1400" angle="-3">
        <%def name="title()">Old computers</%def>
        <%def name="caption()">These memorable artifacts from my living past mark the beginning of an era of alternatives to printing text. My fascination with them also set the trajectory of my career path.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="ornate-printing-press" fid="00000012" x="500" y="1450" width="2000" angle="-2">
        <%def name="title()">Ornate printing press</%def>
        <%def name="caption()">This massive ornate printing press near the entryway had a golden American Eagle at the top. It was among the most visually striking printing presses on display.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="printing-my-name" fid="00000013" x="0" y="300" width="3000" angle="0">
        <%def name="title()">Printing my name</%def>
        <%def name="caption()">In a hands-on demo, we filled this mold with molten metal to create a stamp for printing my name. Whole pages of text were created this way, and the stamps recycled by melting them again.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="typewriters" fid="00000014" x="100" y="300" width="2600" angle="0">
        <%def name="title()">Typewriters</%def>
        <%def name="caption()">My parents posing near a wall of typewriters similar to the one I used in childhood to type papers for school. I remember the smell of the ink, the feel of the keys, and fixing errors with the eraser of a pencil.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="another-printing-press" fid="00000022" x="100" y="300" width="2600" angle="0">
        <%def name="title()">asdf</%def>
        <%def name="caption()">asdf</%def>
    </%bflib:gallery>
    <h2>Visiting the New Hampshire Telephone Museum</h2>
    <p>The last time I saw my parents, we visited the <a href="https://www.nhtelephonemuseum.org/">New Hampshire Telephone Museum</a> together. I recommend visiting the museum to anyone interested learning about the history of telegraphs and telephones from knowledgeable staff, or seeing firsthand some of the fascinating artifacts on which our communications infrastructure is built, past and present. There were also several hands-on demos: telegraphs, manual switchboards, automated switchboards, and early coin operated telephones.</p><p>Beyond that, I had a special reason to take interest in the Telephone Museum. I <a href="/history-of-information/">posted recently</a> on a class I took about Information Theory that I took, and how one of the supplemental readings told through countless anecdotes how information-related technologies changed the world many times over. Well naturally, the exhibits on display in this museum bring to life a wide and important swath of that history. There is even a whole room dedicated to the life of Alexander Bell.</p>
    <%bflib:gallery fn="telegraph-demo" fid="00000015" x="300" y="300" width="3400" angle="0">
        <%def name="title()">Telegraph</%def>
        <%def name="caption()">Before telephones, there were telegraphs. Operators used a key to tap out messages. Visitors to the museum could tap out messages of their own between two such telegraphs.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="older-telephone" fid="00000016" x="1100" y="1500" width="900" angle="-1">
        <%def name="title()">Older telephone</%def>
        <%def name="caption()">The museum had many telephones on display, from the oldest originals to the more modern, in a series of progressions.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="manual-switchboard" fid="00000017" x="800" y="900" width="1300" angle="-1">
        <%def name="title()">Manual switchboard</%def>
        <%def name="caption()">An overwhelmed overworked operator would route and manage calls by plugging cables into this switchboard. The switchboard had indicators to show when lines were no longer in use or the paid time had expired.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="telephone-cable-cross-section" fid="00000018" x="400" y="800" width="2100" angle="0">
        <%def name="title()">Telephone cable cross section</%def>
        <%def name="caption()">Just imagine the many conversations happening side by side along these wires, and the sheer weight of it all.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="undersea-telephone-cable" fid="00000019" x="1400" y="0" width="2500" angle="0">
        <%def name="title()">Undersea telephone cable</%def>
        <%def name="caption()">To connect continents, telephone cables had to be routed under the ocean. Many extra layers helped the cables survive and operate in the harsh undersea environment.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="automated-switchboard" fid="00000020" x="1600" y="1750" width="500" angle="-3">
        <%def name="title()">Automated switchboard</%def>
        <%def name="caption()">Automated mechanical switchboards eventually replaced manual ones. I never fully understood how it worked, but this switchboard could route calls between two actual phones in the exhibit!</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="newer-telephone" fid="00000021" x="500" y="1450" width="2400" angle="0">
        <%def name="title()">Newer telephone</%def>
        <%def name="caption()">This more modern telephone is similar to those I used growing up. Users had to spin the dial for each digit in the number they wanted to call, and when they released it, the phone sent a different number of clicks over the line.</%def>
    </%bflib:gallery>
    <%bflib:gallery fn="outside-telephone-museum" fid="00000023" x="100" y="0" width="3700" angle="0">
        <%def name="title()">Outside the museum</%def>
        <%def name="caption()">asdf</%def>
    </%bflib:gallery>
    <h2>The future of humans and information</h2>
</%block>