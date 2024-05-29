<%!
    title_ = 'Arch Linux on Lenovo Thinkpad P52s'
    date_ = '2024-04-22'
    enable_codesnippets_ = True
    enable_download_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">
    <p>Arch Linux offers the chance to build a system from the ground up, adding and configuring one component at a time, with the help of a well maintained wiki. Understanding the components and how they interact is a fun hobby, but also something of a time sink - especially considering the availability of other high quality Linux distributions out there, that come ready to use. I document here my process of setting up Arch. The device names are specific to my hardware. My process comes from the wiki and from various sources from around the internet. I include links along the way for attribution and further reading.</p>

    <h2>Reference configuration files</h2>
    <%bflib:download_group>
        <%bflib:download file="sample.txt">
            Just testing the look and feel of this new little def block.
        </%bflib:download>
        <%bflib:download file="hostname">
            Just testing the look and feel of this new little def block.
        </%bflib:download>
    </%bflib:download_group>

    <h2>Overview</h2>
    <p>I start with the installation image already on a USB thumb drive. How to reach that point depends on the operating system available to download the image and restore it to the thumb drive. The <a href="https://wiki.archlinux.org/title/Installation_guide#Acquire_an_installation_image">installation image section</a> of the official guide can help. I finish with booting into the system as a non-root user who has internet access and can run <code>sudo</code>. My installation has two notable features:</p>
    <ul>
    <li><p><b>Encrypted home directories.</b> I use <code>dmcrypt</code> to encrypt all home directory data at rest, meaning attackers with physical access to the laptop cannot remove the disk and read the data without getting past the encryption first. Such attackers can still read and write data on other parts of the file system, however. For instance they can see installed software, read any sensitive data that may have leaked into the logs, or make arbitrary modifications to the system including installing malware. Legitimate users enter a password on startup to decrypt the home directories.</p>
    <li><p><b>Snapshot support.</b> Experimenting with software packages and configurations risks leaving the system in an unusable state. Even routine updates can sometimes break the system, allegedly. I use a <code>btrfs</code> root partition and a utility called <code>snapper</code> to revert unwanted changes reliably. I practice reverting a mock unwanted change in this way at the end of the article.</p>
    </ul>

    <h2>Preliminaries</h2>
    <p>TODO Discuss disabling secure boot</p>
    <p>TODO Discuss selecting boot device</p>

    <h2>Partitions</h2>
    <p>Worth mentioning but hopefully already well understood, <strong>this process erases any and all data currently on the disk</strong>. I mostly follow <a href="https://tforgione.fr/posts/arch-linux-encrypted/">Thomas Forgione</a> here, especially for <code>dmcrypt</code> - with the exception that I choose a <code>btrfs</code> filesystem for our root partition to support the goal of snapshotting later. The device corresponding to our disk is <code>/dev/nvme0n1</code>.</p>
    <%bflib:codesnippet lang="bash">
fdisk /dev/nvme0n1
    </%bflib:codesnippet>
    <p>I now find myself in a <code>fdisk</code> interactive shell. My tasks here are to</p>
    <ul>
    <li><p><b>Delete all existing partitions.</b> My disk contains some partitions already, which I have to remove remove. I enter <kbd>d</kbd> and accept the default partition number repeatedly, until there are no partitions left to delete.</p>
    <li><p><b>Create boot partition.</b> The bootloader will live here. The associated device is <code>/dev/nvme0n1p1</code>, and I will later mount it to <code>/boot/efi</code>. I enter <kbd>n</kbd> to create a partition, accept the default partition number, accept the default starting sector, and enter <kbd>+100M</kbd> for the size. If asked about removing an existing signature, I enter <kbd>y</kbd>.</p>
    <li><p><b>Create root partition.</b> Binaries, global configuration, and logs will live here. The associated device is <code>/dev/nvme0n1p2</code>, and I will later mount it to <code>/</code>. I enter <kbd>n</kbd> to create a partition, accept the default partition number, accept the default starting sector, and enter <kbd>+80G</kbd> for the size. If asked about removing an existing signature, I enter <kbd>y</kbd>.</p>
    <li><p><b>Create swap partition.</b> I see recommendations for swap partitions ranging from <i>double the size of RAM</i> to <i>don't have a swap partition</i>. <a href="https://phoenixnap.com/kb/linux-commands-check-memory-usage">Vladimir Kaplarevic</a> discusses recommendations for various Linux distributions. I enter <kbd>n</kbd> to create a partition, accept the default partition number, accept the default starting sector, and enter <kbd>+36G</kbd> for the size. If asked about removing an existing signature, I enter <kbd>y</kbd>.</p>
    <li><p><b>Create home partition.</b> User files live here. This partition will occupy all the remaining space on the disk. The associated device is <code>/dev/nvme0n1p3</code>. I enter <kbd>n</kbd> to create a partition, accept the default partition number, accept the default starting cluster, and accept the default ending sector. If asked about removing an existing signature, I enter <kbd>y</kbd>.</p>
    <li><p><b>Save changes.</b> I optionally enter <kbd>p</kbd> to view my proposed changes to the partition table. I enter <kbd>w</kbd> to write these changes to the disk and exit <code>fdisk</code>.</p>
    </ul>
    <p>I next set up encryption on <code>/dev/nvme0n1p3</code>, which will become the home partition. I encrypt this partition with <code>cryptsetup luksFormat</code>, and then use <code>cryptsetup luksOpen</code> to create a new device called <code>/dev/mapper/luks_home</code> which I can then use to interact with <code>/dev/nvme0n1p1</code> in its decrypted form. The <code>cryptsetup luksFormat</code> utility asks me to create a password when I format the partition, and I subsequently have to supply that password every time I run <code>cryptsetup luksOpen</code>.
    <%bflib:codesnippet lang="bash">
cryptsetup luksFormat /dev/nvme0n1p3
cryptsetup luksOpen /dev/nvme0n1p3 luks_home
    </%bflib:codesnippet>
    <p>I continue on to format the partitions. I choose a <code>vfat</code> filesystem for the boot partition, to support the <code>grub</code> bootloader. I choose a <code>btrfs</code> filesystem for the root partition, to support system snapshots. I choose the standard <code>ext4</code> filesystem for the home partition, using <code>/dev/mapper/luks_home</code> to access that partition now. Finally, I mount all the partitions.</p>
    <%bflib:codesnippet lang="bash">
mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
mkfs.ext4 /dev/mapper/luks_home

mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot/efi
mount --mkdir /dev/mapper/luks_home /mnt/home
    </%bflib:codesnippet>

    <h2>Installation</h2>
    <p>I connect to the internet, assuming access to a wifi network called <code>MyNetwork</code> with a passphrase <code>MyPassphrase</code>.</p>
    <%bflib:codesnippet lang="bash">
iwctl --passphrase MyPassphrase station wlan0 connect MyNetwork
    </%bflib:codesnippet>
    <p>I install Arch. The installation automatically runs <code>mkinitcpio</code> to build a ramdisk, but the ramdisk it builds is not sufficient because of our encrypted home partition. Some warnings about <i>possibly missing firmware</i> also appear during the <code>mkinitcpio</code> run. These warnings do not seem to matter (but I may research them later).</p>
    <%bflib:codesnippet lang="bash">
pacstrap -K /mnt base linux linux-firmware
    </%bflib:codesnippet>
    <p>I now populate <code>fstab</code>, which describes how the partitions should be mounted. I optionally view the <code>fstab</code> before and after populating it, and then enter the installed system.</p>
    <%bflib:codesnippet lang="bash">
cat /mnt/etc/fstab
genfstab -Up /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

arch-chroot /mnt
    </%bflib:codesnippet>

    <h2>Configuration</h2>
    <p>With editing configuration files among my first priorities, having a terminal-based text editor will help. I install <code>vi</code>, but alternatively I could choose a different text editor like <code>nano</code> which has an easier learning curve.</p>
    <%bflib:codesnippet lang="bash">
pacman -S vi
    </%bflib:codesnippet>
    <p>I set a password for the root user.</p>
    <%bflib:codesnippet lang="bash">
passwd
    </%bflib:codesnippet>
    <p>I find the region and city that best fit my own by browsing the available regions and cities with <code>ls</code>. Assuming I live in region <code>MyRegion</code> and near city <code>MyCity</code>, I set our time zone by creating a symbolic link from <code>/etc/localtime</code> to that city.</p>
    <%bflib:codesnippet lang="bash">
ls /usr/share/zoneinfo
ls /usr/share/zoneinfo/MyRegion

ln -sf /usr/share/zoneinfo/MyRegion/MyCity /etc/localtime
    </%bflib:codesnippet>
    <p>I generate the file <code>/etc/adjtime</code> per the installation guide.
    <%bflib:codesnippet lang="bash">
hwclock --systohc
    </%bflib:codesnippet>
    <p>I edit <code>/etc/locale.gen</code>, removing the <code>#</code> from the beginning of the line <code>en_US.UTF-8 UTF-8</code>. Then I generate the locales.</p>
    <%bflib:codesnippet lang="bash">
vi /etc/locale.gen
locale-gen
    </%bflib:codesnippet>

    <h2>Ramdisk</h2>
    <p>Flow of control apparently passes through two components before the operating system loads. It passes through a <em>bootloader</em> and an <em>initial ramdisk</em>. The details and choices are easy to get lost in, but <a href="https://forum.osdev.org/viewtopic.php?t=33029">Brendan</a> and others discuss the nuances and responsibilities of these components. I again follow <a href="https://tforgione.fr/posts/arch-linux-encrypted/">Thomas Forgione</a> here for help the encrypted home directories.</p>
    <p>I edit <code>/etc/mkinitcpio.conf</code>. On the line that starts with <code>HOOKS</code>, I add <kbd>encrypt</kbd> between <code>block</code> and <code>filesystems</code>. I then rebuild the ramdisk. This change causes the ramdisk to prompt for a password to decrypt the home partition on startup. The warnings about unsupported hardware still appear.</p>
    <%bflib:codesnippet lang="bash">
vi /etc/mkinitcpio.conf
mkinitcpio -P
    </%bflib:codesnippet>

    <h2>Bootloader</h2>
    I choose <code>grub</code> for my bootloader. I install its <code>pacmac</code> package and edit the <code>/etc/default/grub</code> file. I remove the <code>#</code> from the line <code>GRUB_ENABLE_CRYPTODISK=y</code> and set the value of <code>GRUB_CMDLINE_LINUX</code> to <code>"cryptdevice=/dev/nvme0n1p3:luks"</code>. Finally, I install grub and create its configuration.</p>
    <%bflib:codesnippet lang="bash">
pacman -S grub efibootmgr
vi /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub
grub-mkconfig -o /boot/grub/grub.cfg
    </%bflib:codesnippet>

    <h2>Networking</h2>
    <p>I have internet access now, but only because I booted from the installation media. Because we have not yet installed the requisite packages for internet access, if I reboot without the installation media then I will be offline. Different guides suggest different package options here, but <code>iwd</code> is contemporary and sufficient. I install <code>iwd</code> and enable it, so it starts automatically on boot. I also enable the default name resolution service.</p>
    <%bflib:codesnippet lang="bash">
pacman -S iwd
systemctl enable iwd
systemctl enable systemd-resolved.service
    </%bflib:codesnippet>
    <p>Even now <code>iwd</code> needs more configuration before I can talk to other servers. I create the file <code>/etc/iwd/main.conf</code> and add the following content.</p>
    <%bflib:codesnippet lang="bash">
[General]
EnableNetworkConfiguration=true

[Network]
EnableIPv6=true
NameResolvingService=systemd
RoutePriorityOffset=300
    </%bflib:codesnippet>
    <p>I also choose a hostname, for example <code>MyHostname</code>.</p>
    <%bflib:codesnippet lang="bash">
echo MyHostname > /etc/hostname
    </%bflib:codesnippet>

    <h2>Rebooting</h2>
    We now return to the original shell, unmount the disks, and reboot the laptop.
    <%bflib:codesnippet lang="bash">
exit
umount -R /mnt
reboot
    </%bflib:codesnippet>
TODO Talk about restoring bios settings
    Log into the system as the <code>root</code> user.
    <h2>Regular user</h2>
    <p>Our first task is to create a less privileged user <code>MyUser</code> for our everyday use of the system, but to allow this user to escalate to <code>root</code> when we need to manage packages or do maintenance. We accomplish escalation using a utility called <code>sudo</code>. Install <code>sudo</code>. Then edit <code>/etc/sudoers</code> and uncomment the line <code>%wheel ALL=(ALL:ALL) ALL</code>. The documentation says to only edit <code>/etc/sudoers</code> with a utility called <code>visudo</code>. This requires installation of the <code>vi</code> package, and knowledge of how to use <code>vi</code>. I have edited <code>/etc/sudoers</code> directly using <code>nano</code> without issue in the past. Add <code>MyUser</code> to the system, putting them in the <code>wheel</code> group so they can run <code>sudo</code>, creating them a home directory, and putting them in a bash shell when they log in. Give them a password to log in with. Finally, log out of the current <code>root</code> session, and log in as <code>MyUser</code>. All the remaining tasks can be done as <code>MyUser</code> now, and we should not need to log in as <code>root</code> again.</p>
    <%bflib:codesnippet lang="bash">
pacman -S sudo
visudo
useradd -m -G wheel -s /bin/bash MyUser
passwd MyUser
exit
    </%bflib:codesnippet>

    <h2>Snapshots</h2>
    <p>TODO Discuss <code>snapper</code></p>

    <hr>
    <p>Things left to do add:</p>
    <ul>
    <li>What about GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub?
    <li>What about further customizing grub?
    <li>Audit other mkinitcpio issues like fsck?
    <li>Hardware support?
    <li>Docking station with three monitors?
    <li>And so many more...
    </ul>

</%block>