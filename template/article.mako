<%inherit file="page.mako" />
<%block name="pageResources">
    <link rel="stylesheet" href="/article.css">
    <%block name="articleResources"/>
</%block>
<%block name="main">
    <div class="article-date">${self.attr.date_}</div>
    <h1>${self.attr.title_}</h1>
    <%block name="article"/>
</%block>