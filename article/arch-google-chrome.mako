<%!
    title_ = 'Google Chrome on Arch Linux'
    date_ = '2024-07-21'
    enable_codesnippets_ = True
    enable_lang_bash_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="summary">
    After installing Arch Linux, I got <code>google-chrome</code> from the AUR running by way of installing <code>sway</code>, <code>git</code>, and <code>yay</code>. I configured these packages only minimally for getting started purposes.
</%block>
<%block name="article">

    <h2>References</h2>
    <ul>
    <li>
    <div><b><a href="https://itsfoss.com/install-yay-arch-linux/">Abhishek Prakash's tutorial on installing yay</a></b></div>
    <div>Straightforward installation instructions for <code>yay</code> on Arch Linux. Also contains instructions for updating <code>yay</code> and removing it.</div>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Git">Arch wiki on git</a></b></div>
    <div>Talks about installation and has usage examples. Lists many graphical front-ends available on Arch Linux.</div>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Sway">Arch wiki on sway</a></b></div>
    <div>How to install and configure <code>sway</code> on Arch Linux. Thorough and informative, but complimentary tutorials may help.</div>
    <li>
    <div><b><a href="https://www.jeremymorgan.com/tutorials/linux/how-to-install-google-chrome-arch-linux/">Jeremy Morgan's tutorial on installing Google Chrome</a></b></div>
    <div>Covers how to install <code>google-chrome</code> on Arch Linux straight from the AUR, and alternatively with <code>yay</code>. Nothing new, but well put together.</div>
    <li>
    <div><b><a href="https://www.reddit.com/r/Fedora/comments/rkzp78/make_chrome_run_on_wayland_permanently/">Chrome on wayland</a></b></div>
    <div>Redditors discuss additional configuration needed in some cases to start Chrome successully on wayland. Amalgamation of many little problems and solutions per usual.</div>
    </ul>

    <h2>Installing sway</h2>
    <p>Chrome needs a graphical environment to run in, such as a wayland compositor like <code>sway</code>. Install <code>sway</code> and choose <code>gnu-free-fonts</code> when the installation process asks about a font. Other choices probably work fine. Also install <code>alacritty</code> which is a terminal for <code>sway</code>. Copy the default <code>sway</code> configuration file to the user home directory. Edit the configuration file to set <code>alacritty</code> as the default terminal. Launch sway. Open a terminal by pressing the <i>Win+Enter</i> keys together. Continue to the remaining steps in the <code>alacritty</code> terminal.</p>
    <%bflib:codesnippet lang="bash">
# Install sway and alacritty
sudo pacman -S sway alacritty

# Use the default sway configuration file
mkdir -p ~/.config/sway
cp /etc/sway/config ~/.config/sway

# Change "set $term foot" to "set $term alacritty"
vim ~/.config/sway/config

# Launch sway
sway
    </%bflib:codesnippet>

    <h2>Installing git</h2>
    <p>Chrome is not available through <code>pacman</code>, only through the AUR. A straightforward way to use AUR is with the <code>yay</code> package. The most straightforward way to install <code>yay</code> is cloning it using <code>git</code>.</p>
    <p>Install <code>git</code>. Optionally set the name for default branches. This avoids warning messages when cloning repositories. The common choice used to be <i>master</i> but recently seems to have shifted to <i>main</i>. Optionally set a <i>name</i> and <i>email</i> which will attribute authorship to future commits.</p>
    <%bflib:codesnippet lang="bash">
sudo pacman -S git

git config --global init.defaultBranch main
git config --global user.name "My Name"
git config --global user.email "myemail@bitflippin.com"
    </%bflib:codesnippet>

    <h2>Installing yay</h2>
    <p>Clone the <code>yay</code> repository. Build and install <code>yay</code>. Once installed the repository is no longer necessary. Interestingly <code>yay</code> seems to install itelf as a <code>yay</code> package!</p>
    <%bflib:codesnippet lang="bash">
git clone https://aur.archlinux.org/yay.git
cd yay
sudo pacman -S base-devel
makepkg -si
cd ..
rm -rf yay
    </%bflib:codesnippet>

    <h2>Google Chrome</h2>
    <p>All that remains is to install Google Chrome and run it. On wayland the additional flag below may be necessary. It is for me.</p>
    <%bflib:codesnippet lang="bash">
yay -S google-chrome
google-chrome-stable --ozone-platform=wayland
    </%bflib:codesnippet>
    <p>Small usability gaps like having <code>sway</code> start on login, having <code>google-chrome-stable</code> launch without a terminal, and further customizations of <code>sway</code> still remain; however these steps are sufficient to get started.</p>
</%block>