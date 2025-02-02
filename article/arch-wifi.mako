<%!
    title_ = 'Wifi on Arch Linux'
    date_ = '2024-07-11'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    After installing Arch Linux and the <code>iwd</code> and <code>openresolv</code> packages, I set up wireless internet access on a Lenovo Thinkpad P52s.
</%block>
<%block name="article">
    <p>These instructions configure and enable two services. The <code>iwd</code> service provides wireless internet access. The <code>systemd-resolved</code> service provides domain name resolution. These instructions also cover network configuration steps leftover from the minimal Arch installation.</p>

    <h2>Networking</h2>
    <p>On a single line in <code>/etc/hostname</code> assign the machine a hostname. For example the entire contents of the file could be <kbd>MyHostname</kbd>. Local applications can use the hostname to reference the machine.</p>
    <%bflib:codesnippet lang="bash">
vim /etc/hostname
    </%bflib:codesnippet>

    <h2>Name resolution service</h2>
    <p>I tried extensively to get <code>systemd-resolved</code> working but could not get past an issue where many names resolved but some did not, including the name of this site for instance. I switched to <code>resolvconf</code>.</p>
    <p>Per the Arch wiki, create the <code>resolv.conf</code> configuration file.</p>
    <%bflib:codesnippet lang="bash">
resolvconf -u
    </%bflib:codesnippet>

    <h2>Wireless service</h2>
    <p>There is no <code>iwd</code> configuration file by default. Paste in this minimal configuration file when the time comes.</p>
    <%bflib:codesnippet title="/etc/iwd/main.conf" lang="linuxconfig">
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=resolvconf
    </%bflib:codesnippet>
    <p>Start and enable the <code>iwd</code> service. Starting the service launches it immediately. Enabling the servicec causes it to start automatically on boot. Connect to the internet wirelessly, replacing <kbd>MyNetwork</kbd> and <kbd>MyPassphrase</kbd> appropriately.</p>
    <%bflib:codesnippet lang="bash">
# Create the iwd config file
vim /etc/iwd/main.conf

# Start and enable iwd
systemctl enable iwd
systemctl start iwd

# Connect to a wireless network
iwctl --passphrase MyPassphrase station wlan0 connect MyNetwork

# Optionally view the network file that was created
cat /var/lib/iwd/MyNetwork.psk
    </%bflib:codesnippet>
    <p>Further wireless refinements are possible and likely desirable. The installation guides consulted contain additional network configuration recommendations I do not yet understand. Meanwhile these steps suffice to make the Arch installation usable.</p>
</%block>
<%block name="references">
    <%bflib:reference title="Installation guide references" url="https://bitflippin.com/article/arch-p52s/">The installation guides referenced in the initial Arch installation article all include wireless internet setup instructions rather than treating them as a separate process.</%bflib:reference>
    <%bflib:reference title="Arch wiki on wireless service" url="https://wiki.archlinux.org/title/Iwd">How to connect to a wireless network with <code>iwd</code>. Background about how <code>iwd</code> works and how to configure it.</%bflib:reference>
    <%bflib:reference title="Hostname resolution" url="https://unix.stackexchange.com/questions/186859/understand-hostname-and-etc-hosts">Informative discussion about local name resolution including explanations of <code>/etc/hostname</code> and <code>/etc/hosts</code>.</%bflib:reference>
</%block>