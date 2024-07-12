<%!
    enable_article_ = True
%>
<%inherit file="page.mako"/>
<%block name="main">
    <div class="article-date">
    <div>${self.attr.date_}</div>
    </div>
    <h1>${self.attr.title_}</h1>
    <%block name="article"/>
</%block>