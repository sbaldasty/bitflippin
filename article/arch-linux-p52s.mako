<%!
    title_ = 'Installing Arch Linux on a Lenovo Thinkpad P52s'
    date_ = '2024-04-22'
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">
    <aside>The process I present here is a patchwork of building blocks from around the internet. Some are customized. I include links along the way for attribution and further reading.</aside>

    <p>We start with the installation image already on a USB thumb drive. How to reach that point depends on what operating system we have available. The <a href="https://wiki.archlinux.org/title/Installation_guide#Acquire_an_installation_image">installation image section</a> of the official guide is sprawling, but can help. We finish when we can boot into the system as a non-root user who has internet access and can run <code>sudo</code>. Our installation has two notable features:</p>

    <ul>
    <li><p><b>Encrypted home directories.</b> We use <code>dmcrypt</code> to encrypt all home directory data at rest, meaning attackers with physical access to the laptop cannot remove the disk and read the data without getting past the encryption first. Legitimate users enter a password on startup to decrypt the home directories.</p>
    <li><p><b>Snapshot support.</b> When experimenting with software packages and configurations, reverting system changes can be daunting and error-prone. Allegedly even routine updates sometimes break the system. We use a <code>btrfs</code> partition and <code>snapper</code> to revert unwanted changes reliably.</p>
    </ul>

    <h2>Boot from thumb drive</h2>
    asdf

    <h2>Partition disk</h2>
    <p>It is worth mentioning but hopefully already well understood, <strong>this process erases our entire disk</strong>. We mostly follow <a href="???">???</a> here, especially for <code>dmcrypt</code>, with the exception that we choose a <code>btrfs</code> filesystem for our root partition to support our goal of snapshotting later. The device corresponding to our disk is <code>???</code>, but this varies across machines.</p>
    <pre>fdisk ???</pre>
    <ul>
    <li><p><b>Delete existing partitions.</b> asdf</p>
    <li><p><b>New boot partition.</b> asdf. The associated device is <code>/dev/nvm???</code>.</p>
    <li><p><b>New root partition.</b> Binaries, global configuration, and logs will live here. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting sector, and enter <code>+50G</code> for the size. The associated device is <code>/dev/nvm???</code>.</p>
    <li><p><b>New home partition.</b> User files will live here. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting cluster, and accept the default ending sector. The home partition occupies all the remaining space on the disk. The associated device is <code>/dev/nvm???</code>.</p>
    <li><p><b>Save changes.</b> We enter <code>w</code> to write these changes to the disk and exit <code>fdisk</code>.</p>
    </ul>
    TODO Show the partitions?
    <h2>asdf</h2>
    <pre>hostname swiftie</pre>
    <h2>Install packages</h2>
    <p>base stuff</p>
    <pre>asdf</pre>
    <p>We have internet access now, but only because we booted from the installation media: <font color="green">swiftie</font> does not yet have the requisite packages for internet access, and when we eventually reboot without the installation media we will be offline. Different guides suggest different package options here, but <code>iwd</code> is contemporary and sufficient. We install <code>iwd</code> now, and will configure it when we boot into the system for the first time.</p>
    <pre>pacman -S iwd</pre>
    <p>For the same reason, we will lose access to <code>nano</code> too when we reboot without the installation media. Since editing configuration files will be among our first priorities, we install <code>nano</code> now. Alternatively we could choose a different text editor.</p>
    <pre>pacman -S nano</pre>
    <h2>Reboot</h2>
    asdf
    <h2>Create normal user</h2>
    asdf
    <pre>pacman -S sudo</pre>
    asdf
    <pre>useradd -m -G wheel -s /bin/bash <i>username</i></pre>
    <h2>Configure wifi</h2>
    asdf
    <pre>systemctl enable iwd</pre>
    We want internet access now though, without having to reboot <font color="green">swiftie</font> again, so we start the <code>iwd</code> service manually.
    <pre>systemctl start iwd</pre>
    <p>Now we can connect to a wifi network using the <code>iwctl</code> client.</p>
    asdf

</%block>