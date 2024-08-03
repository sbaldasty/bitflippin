<%!
    title_ = 'Museums about information theory'
    date_ = '2023-08-09'
    enable_gallery_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    I took an information theory class at UVM, and later visited two information theory related museums: the Museum of Printing and the New Hampshire Telephone Museum.
</%block>
<%block name="article">

    <h2>References</h2>
    <ul>
    <li><div><b><a href="https://www.amazon.com/Information-History-Theory-Flood/dp/1400096235">The Information: A History, A Theory, A Flood</a></b></div><div>Amazon page for a good book about the humanity's history with information.</div>
    <li><div><b><a href="https://www.museumofprinting.org/">Museum of Printing homepage</a></b></div><div>Includes location, hours of operation, events calendar, membership information, volunteer opportunities, and exhibit pictures.</div>
    <li><div><b><a href="https://www.nhtelephonemuseum.org/">New Hampshire Telephone Museum homepage</a></b></div><div>Includes location, hours of operation, membership information, and online store.</div>
    <li><div><b><a href="https://www.tandfonline.com/doi/abs/10.1080/00207166808803030">Three Approaches to the Quantitative Definition of Information</a></b></div><div>Andrei Kolmogorov's paper about different perspectives on how to measure an <i>amount</i> of information.</div>
    </ul>

    <h2>Information theory</h2>
    <p>Imagine having a piece of text, audio, images, video, or other media. Now imagine a scenario where that media gets sent to another place or to a future time. We encode the media as a sequence of bits called a <i>message</i>. We set aside any notion of meaning the message represents. We send the message through a <i>channel</i> such as a telephone cable or hard drive. We recover the media by decoding the message. Important considerations arise. How for efficiency can we send the message with the fewest number of bits? Conversely how can we add redundancy to protect the message from corruption due to noise in the channel?</p>

    <p>A related question is how to measure the amount of information in a message. A <i>combinatorial</i> approach counts how many symbols the message contains. The symbols are usually bits. <i>Shannon Entropy</i> also consider the predictability of the next symbol given the symbols that have appeared before. <i>Kolmogorov Complexity</i> asks instead, how long is the shortest computer program that generates the sequence? Information theory as we studied it mostly considered Shannon Entropy.</p>

    <h2>A history, a theory, a flood</h2>

    <p>One of the supplementary resources for the class was a less technical book called <i>The Information: A History, A Theory, A Flood</i> by James Gleik. The book tells the story of humanity's rapidly accelerating dance with information with countless anecdotes from ancient history to the present day. It tells how each advance brought profound societal changes and affected the thinking of everyday people in big ways. A few of my favorites were</p>

    <ul>
    <li><p>How in Africa, drums using two pitches could spread news between villages. African drumming was for centuries a long-unparalleled means of communication over enormous distances.</p>
    <li><p>How writing emerged from ancient spoken language and made it possible for information to pass unaltered through space and time.</p>
    <li><p>How in the American West during the early days of telephony, landowners formed a large improvised telephone network through the barbed wire of their fences.</p>
    <li><p>How Robert Cawdrey compiled the first English dictionary, and communicated the notion of what a dictionary even is to the public.</p>
    <li><p>How before people harnessed electricity, Charles Babbage designed a mechanical general purpose computer; and how his collaborator Ada Lovelace worked out how to solve problems with his imaginary computer, and is widely considered the very first computer programmer.</p>
    <li><p>How Claude Shannon and other brilliant thinkers like Andrei Kolmogorov formalized information theory, and laid the foundations for modern electronic communication.</p>
    </ul>

    <p>Spending time with historical artifacts from the worlds of printing and telephony naturally brought to life for me a large important swath of that history.</p>

    <%bflib:gallery>
    <%bflib:photo fn="campus-at-dusk" fid="00000001" x="200" y="0" width="2900" angle="0">
        <%def name="title()">UVM campus at dusk</%def>
        <%def name="caption()">Black ghostlike statues glide across the courtyard just before sunset, around when I stopped working and started graduate school. Students hang cozy hammocks between these trees in warmer weather.</%def>
    </%bflib:photo>
    </%bflib:gallery>

    <h2>The Museum of Printing</h2>

    <p>The Museum of Printing is in Haverhill, MA. It has fascinating hands-on exhibits and knowledgeable staff who are happy to answer questions and offer guided tours. From its About Page,</p>

    <blockquote>The Museum of Printing is dedicated to preserving the rich history of the graphic arts, printing and typesetting technology, and printing craftsmanship. In addition to many special collections and small exhibits, the Museum contains hundreds of antique printing, typesetting, and bindery machines, as well as a library of books and printing-related documents.</blockquote>

    <p>Someone there even walked me through the process of making a cast of my name from a light molten metal in the same way an operator would prepare a page for mass production. After printing enough copies, they could melt the cast down again and reuse the metal for another page, but I got to keep my name!</p>

    <%bflib:gallery>
    <%bflib:photo fn="ancient-chinese-printing" fid="00000007" x="500" y="1450" width="500" angle="0">
        <%def name="title()">Ancient Chinese printing technology</%def>
        <%def name="caption()">Symbols were selected from this wheel and used in something like a printing press. This technology predated the European printing press, but it was tightly controlled by the government and never spread widely.</%def>
    </%bflib:photo>
    <%bflib:photo fn="bible-page-1830" fid="00000008" x="500" y="1300" width="800" angle="0">
        <%def name="title()">Bible page from 1830</%def>
        <%def name="caption()">Bibles were an early priority for the printing press during the Protestant revolution and beyond. They played an important role in European and American society, and continue to play an important role for many today.</%def>
    </%bflib:photo>
    <%bflib:photo fn="colored-bible-illustration" fid="00000009" x="550" y="0" width="3400" angle="-90">
        <%def name="title()">Colored illustration from a Bible</%def>
        <%def name="caption()">Many painstakingly colored illustrations from very old Bibles were on display here. I wish I understood the significance of the details in these illustrations better than I do.</%def>
    </%bflib:photo>
    <%bflib:photo fn="early-color-printer" fid="00000010" x="0" y="400" width="2600" angle="0">
        <%def name="title()">Early color printer</%def>
        <%def name="caption()">This was one of the earlier electronic machines that could print in color at scale. The more modern machines displayed nearby illustrate the miniaturization this technology underwent.</%def>
    </%bflib:photo>
    <%bflib:photo fn="old-computers" fid="00000011" x="1150" y="1000" width="1400" angle="-3">
        <%def name="title()">Old computers</%def>
        <%def name="caption()">These memorable artifacts from my living past mark the beginning of an era of alternatives to printing text. My fascination with them also set the trajectory of my career path.</%def>
    </%bflib:photo>
    <%bflib:photo fn="ornate-printing-press" fid="00000012" x="500" y="1450" width="2000" angle="-2">
        <%def name="title()">Ornate printing press</%def>
        <%def name="caption()">This massive ornate printing press near the entryway had a golden American Eagle at the top. It was among the most visually striking printing presses on display.</%def>
    </%bflib:photo>
    <%bflib:photo fn="printing-my-name" fid="00000013" x="0" y="300" width="3000" angle="0">
        <%def name="title()">Printing my name</%def>
        <%def name="caption()">In a hands-on demo, we filled this mold with molten metal to create a stamp for printing my name. Whole pages of text were created this way, and the stamps recycled by melting them again.</%def>
    </%bflib:photo>
    <%bflib:photo fn="typewriters" fid="00000014" x="100" y="300" width="2600" angle="0">
        <%def name="title()">Typewriters</%def>
        <%def name="caption()">My parents posing near a wall of typewriters similar to the one I used in childhood to type papers for school. I remember the smell of the ink, the feel of the keys, and fixing errors with the eraser of a pencil.</%def>
    </%bflib:photo>
    </%bflib:gallery>

    <h2>The New Hampshire Telephone Museum</h2>

    <p>The New Hampshire Telephone Museum is in Warner, NH. I recommend visiting the museum to anyone interested learning about the history of telegraphs and telephones or seeing firsthand some of the fascinating artifacts on which our communications infrastructure is built, past and present. It also have several hands-on demos: telegraphs, manual switchboards, automated switchboards, and early coin operated telephones. There is a whole room dedicated to the life of Alexander Bell.</p>

    <%bflib:gallery>
    <%bflib:photo fn="telegraph-demo" fid="00000015" x="300" y="300" width="3400" angle="0">
        <%def name="title()">Telegraph</%def>
        <%def name="caption()">Before telephones, there were telegraphs. Operators used a key to tap out messages. Visitors to the museum could tap out messages of their own between two such telegraphs.</%def>
    </%bflib:photo>
    <%bflib:photo fn="older-telephone" fid="00000016" x="1100" y="1500" width="900" angle="-1">
        <%def name="title()">Older telephone</%def>
        <%def name="caption()">The museum had many telephones on display, from the oldest originals to the more modern, in a series of progressions.</%def>
    </%bflib:photo>
    <%bflib:photo fn="manual-switchboard" fid="00000017" x="800" y="900" width="1300" angle="-1">
        <%def name="title()">Manual switchboard</%def>
        <%def name="caption()">An overwhelmed overworked operator would route and manage calls by plugging cables into this switchboard. The switchboard had indicators to show when lines were no longer in use or the paid time had expired.</%def>
    </%bflib:photo>
    <%bflib:photo fn="telephone-cable-cross-section" fid="00000018" x="400" y="800" width="2100" angle="0">
        <%def name="title()">Telephone cable cross section</%def>
        <%def name="caption()">Just imagine the many conversations happening side by side along these wires, and the sheer weight of it all.</%def>
    </%bflib:photo>
    <%bflib:photo fn="undersea-telephone-cable" fid="00000019" x="1400" y="0" width="2500" angle="0">
        <%def name="title()">Undersea telephone cable</%def>
        <%def name="caption()">To connect continents, telephone cables had to be routed under the ocean. Many extra layers helped the cables survive and operate in the harsh undersea environment.</%def>
    </%bflib:photo>
    <%bflib:photo fn="automated-switchboard" fid="00000020" x="1600" y="1750" width="500" angle="-3">
        <%def name="title()">Automated switchboard</%def>
        <%def name="caption()">Automated mechanical switchboards eventually replaced manual ones. I never fully understood how it worked, but this switchboard could route calls between two actual phones in the exhibit!</%def>
    </%bflib:photo>
    <%bflib:photo fn="newer-telephone" fid="00000021" x="500" y="1450" width="2400" angle="0">
        <%def name="title()">Newer telephone</%def>
        <%def name="caption()">This more modern telephone is similar to those I used growing up. Users had to spin the dial for each digit in the number they wanted to call, and when they released it, the phone sent a different number of clicks over the line.</%def>
    </%bflib:photo>
    </%bflib:gallery>

    <h2>Reflections</h2>

    <p>Among the final ideas presented in <i>The Information: A History, A Theory, A Flood</i> is that when information is scarce and difficult to access, then it is expensive; but when information is plentiful and easy to access then attention is expensive. In the same way that most people in the past were unable to understand the ways in which new information technologies would affect their lives and minds, I too am unlikely to understand the ways in which new information technologies will affect my life and mind, and those of the generations that follow.</p>

</%block>