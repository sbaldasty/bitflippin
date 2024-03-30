<%inherit file="page.mako" />
<%block name="resources">
    <link rel="stylesheet" href="/article.css">
</%block>
<%block name="main">
    <div class="article-date">${self.attr.date_}</div>
    <h1>${self.attr.title_}</h1>
    <%block name="article"/>
</%block>