<%!
    title_ = 'Github clone script'
    date_ = '2024-07-24'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    After configuring <code>git</code> I wrote a short bash script called <code>ghclone</code> that accepts a github <i>user</i> and <i>repo</i>. It clones the github repository following a particular directory structure.
</%block>
<%block name="article">

    <h2>References</h2>
    <ul>
    <li>
    <div><b><a href="https://bitflippin.com/article/arch-google-chrome/">My notes on git configuration</a></b></div>
    <div>Installation instructions and setting some basic properties. Lumped together with notes on installing other packages on Arch Linux.</div>
    <li>
    <div><b><a href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account">Github on adding ssh keys</a></b></div>
    <div>Explanation of how github uses ssh keys. Detailed instructions on how to create them and add them to a github account.</div>
    </ul>

    <h2>Workflow</h2>
    <p>Bob the developer has already installed and configured <code>git</code>. He has already added a <code>ssh</code> key to his github account. Bob needs to download source code from multiple online services. He wants to organize the source code by service, and whatever directory structure makes sense under that depending on the service. For instance github repositories should live in this directory structure: <code>~/Code/github/<i>user</i>/<i>repo</i></code>. To clone my <i>Hunt the Wumpus</i> java applet Bob runs</p>
    <%bflib:codesnippet lang="bash">
ghclone sbaldasty wumpus-applet
    </%bflib:codesnippet>
    <h2>Script</h2>
    <p>Here is the full <code>ghclone</code> script in its current form. As always please exercise caution with code that interacts with third party systems, and with code that can potentially modify or delete data.</p>
    <%bflib:codesnippet title="ghclone" lang="bash" file="code/github-clone-script/ghclone"/>

    <h2>Shortcomings</h2>
    <p>The script does not clean up any files or directories it created if cloning the repository fails.</p>
</%block>