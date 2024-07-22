<%!
    title_ = 'Home'
    enable_headline_ = True
%>
<%namespace name="bflib" file="bflib.mako" />
<%inherit file="page.mako" />
<%block name="main">
    <h2>Articles</h2>
    <%bflib:headline aid="arch-non-root-user"/>
    <%bflib:headline aid="vacc-script"/>
    <%bflib:headline aid="arch-wifi"/>
    <%bflib:headline aid="arch-p52s"/>
    <%bflib:headline aid="information-theory"/>
    <%bflib:headline aid="time-release-lock"/>
</%block>