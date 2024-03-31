<%!
    enable_article_ = True
%>
<%inherit file="page.mako"/>
<%block name="main">
    <div class="article-date">${self.attr.date_}</div>
    <h1>${self.attr.title_}</h1>
    <%block name="article"/>
</%block>