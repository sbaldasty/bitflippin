<%!
    title_ = 'Non-root user on Arch Linux'
    date_ = '2024-07-13'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    After installing Arch Linux, I added a non-root user with <code>sudo</code> privileges and with privileges to shutdown and restart the machine.
</%block>
<%block name="article">
    <p>Traditionally in Linux systems one creates a non-root user for regular operations. Even in cases where only one person uses the system, having a safeguard against accidentally running dangerous commands as root is nice.</p>

    <h2>References</h2>
    <ul>
    <li>
    <div><b><a href="https://bitflippin.com/article/arch-p52s/">Installation guide references</a></b></div>
    <div>The installation guides referenced in the initial Arch installation article cover setting up non-root users rather than treating it as a separate process.</div>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Users_and_groups#User_management">Arch wiki on user management</a></b></div>
    <div>The arch wiki documents how to add users. It includes several examples.</div>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Sudo">Arch wiki on sudo</a></b></div>
    <div>How to install and configure <code>sudo</code> to allow non-root users to run commands as root.</div>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Polkit">Arch wiki on polkit</a></b></div>
    <div>How to install and configure <code>polkit</code>. Of only tangential interest to this task.</div>
    </ul>

    <h2>Adding the user</h2>
    <p>Add a new user with a home directory and <code>bash</code> for a login shell. Set the new user's password. Optionally exit the root session and test logging in as the new user.</p>
    <%bflib:codesnippet lang="bash">
useradd -m -s /bin/bash MyUsername
passwd MyUsername

# Optionally see the new home directory
ls /home
    </%bflib:codesnippet>

    <h2>Root access</h2>
    <p>Install the <code>sudo</code> package. Edit the <code>sudo</code> configuration file with the special <code>visudo</code> utility per below. Sources recommend doing otherwise, but editing <code>/etc/sudoers</code> directly also seems to work. Add the new user to the <code>wheel</code> group. Optionally test running commands as root by prefixing them with <code>sudo</code> when logged in as the new user.</p>
    <%bflib:codesnippet lang="bash">
# Install sudo
pacman -S sudo

# Uncomment the line "%wheel ALL=(ALL:ALL) ALL"
EDITOR=vim visudo

usermod -a -G wheel MyUsername
    </%bflib:codesnippet>

    <h2>Power privileges</h2>
    <p>For convenience the non-root user should have the ability to shut down and reboot the system. Install the <code>polkit</code> package.</p>
    <%bflib:codesnippet lang="bash">
pacman -S polkit
    </%bflib:codesnippet>
    <p>Surprisingly without enabling any service the non-root user now has the ability to use the <code>shutdown</code> and <code>reboot</code> commands. Perhaps they can now run other commands as well. There are certainly many things I still do not understand about <code>polkit</code>.</p>
</%block>