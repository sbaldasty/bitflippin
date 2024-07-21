<%!
    title_ = 'Wifi on Arch Linux'
    date_ = '2024-07-11'
    enable_codesnippets_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    I set up wireless internet access on a Lenovo Thinkpad P52s after installing Arch Linux and the <code>iwd</code> package.
</%block>
<%block name="article">
    <p>These instructions configure and enable two services. The <code>iwd</code> service provides wireless internet access. The <code>systemd-resolved</code> service provides domain name resolution. These instructions also cover network configuration steps leftover from the minimal Arch installation.</p>

    <h2>References</h2>
    <ul>
    <li>
    <div><b><a href="https://bitflippin.com/article/arch-p52s/">Installation guide references</a></b></div>
    <div>The installation guides referenced in the initial Arch installation article all include wireless internet setup instructions rather than treating them as a separate process.</div>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Iwd">Arch wiki on wireless service</a></b></div>
    <div>How to connect to a wireless network with <code>iwd</code>. Background about how <code>iwd</code> works and how to configure it.</div>
    <li>
    <div><b><a href="https://unix.stackexchange.com/questions/186859/understand-hostname-and-etc-hosts">Hostname resolution</a></b></div>
    <div>Informative discussion about local name resolution including explanations of <code>/etc/hostname</code> and <code>/etc/hosts</code>.</div>
    </ul>

    <h2>Networking</h2>
    <p>On a single line in <code>/etc/hostname</code> assign the machine a hostname. For example the entire contents of the file could be <kbd>MyHostname</kbd>. Local applications can use the hostname to reference the machine.</p>
    <%bflib:codesnippet lang="bash">
vim /etc/hostname
    </%bflib:codesnippet>

    <h2>Name resolution service</h2>
    <p>Per the Arch wiki point the actual name resolution service configuration to the default service configuration. Start and enable the <code>systemd-resolved</code> service. Starting the service launches it immediately. Enabling the servicec causes it to start automatically on boot.</p>
    <%bflib:codesnippet lang="bash">
# Symlink to the default configuration
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Start and enable systemd-resolved
systemctl enable systemd-resolved.service
systemctl start systemd-resolved.service
    </%bflib:codesnippet>

    <h2>Wireless service</h2>
    <p>There is no <code>iwd</code> configuration file by default. Paste in this minimal configuration file when the time comes. The default name resolving service should already be <code>systemd</code> so strictly no need to specify it.</p>
    <%bflib:codesnippet lang="linuxconfig">
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
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