<%!
    enable_article_ = True
%>
<%inherit file="page.mako"/>
<%block name="main">
    <div class="article-date">
    <div>${self.attr.date_}</div>
    </div>
    <h1>${self.attr.title_}</h1>
    <p>
        <%block name="summary"/>
    </p>
    <%block name="article"/>
    <h2>References</h2>
    <ul>
    <%block name="references"/>
    </ul>
</%block>