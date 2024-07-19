<%!
    title_ = 'Git on Arch Linux'
    date_ = '2024-07-11'
    enable_codesnippets_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    asdf summary
</%block>
<%block name="article">

    <p>asdf</h2>
    <%bflib:codesnippet lang="bash">

vim /etc/hostname
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

systemctl enable iwd
systemctl start iwd
systemctl enable systemd-resolved.service
systemctl start systemd-resolved.service

iwctl --passphrase MyPassphrase station wlan0 connect MyNetwork
    </%bflib:codesnippet>
</%block>