<%!
    enable_article_ = True
%>
<%inherit file="page.mako"/>
<%block name="main">
    <p class="article-date">${self.attr.date_}</p>
    <h1>${self.attr.title_}</h1>
    <%block name="article"/>
</%block>