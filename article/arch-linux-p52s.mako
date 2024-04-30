<%!
    title_ = 'Arch Linux on a Lenovo Thinkpad P52s'
    date_ = '2024-04-22'
    enable_codesnippets_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">
    <p>Arch is about building a system from the ground up, adding and configuring one small piece at a time. It is a fun hobby, but like any hobby, it is also something of a time sink - especially considering the availability of high quality ready-to-use Linux distributions out there. This process documents my current setup and learning. It is a patchwork of building blocks captured and customized from around the internet. I usually include links along the way for attribution and further reading.</p>

    <h2>Overview</h2>
    <p>We start with the installation image already on a USB thumb drive. How to reach that point depends on what operating system we have available to download the image and restore it to the thumb drive. The <a href="https://wiki.archlinux.org/title/Installation_guide#Acquire_an_installation_image">installation image section</a> of the official guide can help. We finish when we can boot into the system as a non-root user who has internet access and can run <code>sudo</code>. Our installation has two notable features:</p>
    <ul>
    <li><p><b>Encrypted home directories.</b> We use <code>dmcrypt</code> to encrypt all home directory data at rest, meaning attackers with physical access to the laptop cannot remove the disk and read the data without getting past the encryption first. Legitimate users enter a password on startup to decrypt the home directories.</p>
    <li><p><b>Snapshot support.</b> When experimenting with software packages and configurations, reverting system changes can be daunting and error-prone. Allegedly even routine updates sometimes break the system. We use a <code>btrfs</code> partition and <code>snapper</code> to revert unwanted changes reliably, and practice system recovery.</p>
    </ul>

    <h2>Preliminaries</h2>
    <p>TODO Discuss disabling secure boot</p>
    <p>TODO Discuss selecting boot device</p>
    <p>We will need to internet connectivity for installing packages later. Assuming we have access to a wifi network, we run
    <%bflib:codesnippet lang="bash">
$ iwctl --passphrase MyPassphrase station wlan0 connect MyNetwork
    </%bflib:codesnippet>

    <h2>Partitions</h2>
    <p>Worth mentioning but hopefully already well understood, <strong>this process erases any and all data currently on our disk</strong>. We mostly follow <a href="https://tforgione.fr/posts/arch-linux-encrypted/">Thomas Forgione's post</a> here, especially for <code>dmcrypt</code> - with the exception that we choose a <code>btrfs</code> filesystem for our root partition to support our goal of snapshotting later. The device corresponding to our disk is <code>/dev/nvme0n1</code>.</p>
    <%bflib:codesnippet lang="bash">
fdisk /dev/nvme0n1
    </%bflib:codesnippet>
    <p>We find ourselves in an interactive shell. Our tasks here are to</p>
    <ul>
    <li><p><b>Delete all existing partitions.</b> Our disk likely contains some partitions already, which we will remove. We enter <code>d</code> and accept the default partition number repeatedly, until there are no partitions left to delete.</p>
    <li><p><b>Create a boot partition.</b> Our bootloader will live here. The associated device will be <code>/dev/nvme0n1p1</code>, and we will mount it to <code>/boot/efi</code>. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting sector, and enter <code>+100M</code> for the size. If asked about removing an existing signature, we enter <code>y</code>.</p>
    <li><p><b>Create a root partition.</b> Binaries, global configuration, and logs will live here. The associated device will be <code>/dev/nvme0n1p2</code>, and we will mount it to <code>/</code>. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting sector, and enter <code>+50G</code> for the size. If asked about removing an existing signature, we enter <code>y</code>.</p>
    <li><p><b>Create a home partition.</b> User files will live here. This partition will be the largest, occupying all the remaining space on the disk. The associated device will be <code>/dev/nvme0n1p3</code>. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting cluster, and accept the default ending sector. If asked about removing an existing signature, we enter <code>y</code>.</p>
    <li><p><b>Save changes.</b> We optionally enter <code>p</code> to view our proposed changes to the partition table. We enter <code>w</code> to write these changes to the disk and exit <code>fdisk</code>.</p>
    </ul>
    <p>Attackers with physical access can still access data outside the home directory though, such as what software is installed and anything in log files. TODO note typing YES in capital letters for luksFormat, note passphrase for luksFormat...</p>
    <%bflib:codesnippet lang="bash">
cryptsetup luksFormat /dev/nvme0n1p3
cryptsetup luksOpen /dev/nvme0n1p3 luks_home
    </%bflib:codesnippet>
    <p>TODO Describe...</p>
    <%bflib:codesnippet lang="bash">
mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
mkfs.ext4 /dev/mapper/luks_home
    </%bflib:codesnippet>
    <p>TODO Describe...</p>
<%bflib:codesnippet lang="bash">
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot/efi
mount --mkdir /dev/mapper/luks_home /mnt/home
    </%bflib:codesnippet>

    <h2>Installation</h2>
    <p>TODO Describe... Some warnings about <i>possibly missing firmware</i> appear during the <code>mkinitcpio</code> build. We fill some of these gaps later.</p>
    <%bflib:codesnippet lang="bash">
pacstrap -K /mnt base linux linux-firmware
    </%bflib:codesnippet>
    <p>TODO Describe...</p>
    <%bflib:codesnippet lang="bash">
genfstab -Up /mnt >> /mnt/etc/fstab
    </%bflib:codesnippet>
    <p>Afterwards and optionally, if we want to see the generated <code>fstab</code> we enter
    <%bflib:codesnippet lang="bash">
cat /mnt/etc/fstab
    </%bflib:codesnippet>
    <p>TODO Describe...</p>
    <%bflib:codesnippet lang="bash">
arch-chroot /mnt
    </%bflib:codesnippet>
    <p>TODO Describe... enter same password twice for root user</p>
    <%bflib:codesnippet lang="bash">
passwd
    </%bflib:codesnippet>
Set the time zone:

<%bflib:codesnippet lang="bash">

# ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

    </%bflib:codesnippet>
Run hwclock(8) to generate /etc/adjtime:
<%bflib:codesnippet lang="bash">

# hwclock --systohc

    </%bflib:codesnippet>
Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed UTF-8 locales. Generate the locales by running:

# locale-gen

    <h2>Ramdisk</h2>
    <p>Since editing configuration files will be among our first priorities, we install <code>nano</code> now. Alternatively we could choose a different text editor like <code>vi</code> or <code>vim</code>.</p>
    <%bflib:codesnippet lang="bash">
pacman -S nano
    </%bflib:codesnippet>
    <p>On the line that starts with <code>HOOKS</code>, add <code>encrypt</code> between <code>block</code> and <code>filesystems</code>.</p>
    <%bflib:codesnippet lang="bash">
nano /etc/mkinitcpio.conf
    </%bflib:codesnippet>
    <p>We now rebuild the initial ramdisk.</p>
    <%bflib:codesnippet lang="bash">
mkinitcpio -P
    </%bflib:codesnippet>

    <h2>Networking</h2>
    <p>We have internet access now, but only because we booted from the installation media: swiftie does not yet have the requisite packages for internet access, and when we eventually reboot without the installation media we will be offline. Different guides suggest different package options here, but <code>iwd</code> is contemporary and sufficient. We install <code>iwd</code> now, and will configure it when we boot into the system for the first time.</p>
    <%bflib:codesnippet lang="bash">
pacman -S iwd
    </%bflib:codesnippet>
    <p>TODO Describe...</p>
    <%bflib:codesnippet lang="bash">
echo <i>hostname</i> &gt; /etc/hostname
    </%bflib:codesnippet>
    <p>TODO Describe...</p>
    <%bflib:codesnippet lang="bash">
systemctl enable iwd
    </%bflib:codesnippet>

    <h2>Bootloader</h2>
    <%bflib:codesnippet lang="bash">
pacman -S grub efibootmgr
    </%bflib:codesnippet>
    Edit the /etc/default/grub file. The line GRUB_ENABLE_CRYPTODISK=y should be uncommented, and I also changed the GRUB_CMDLINE_LINUX line:

<%bflib:codesnippet lang="bash">
GRUB_CMDLINE_LINUX="cryptdevice=/dev/nvme0n1p3:luks"
    </%bflib:codesnippet>
Once those modifications are done (or not), you need to install the grub:

<%bflib:codesnippet lang="bash">
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub
grub-mkconfig -o /boot/grub/grub.cfg
    </%bflib:codesnippet>

    <h2>Rebooting</h2>
You can now exit the chroot (Ctrl+D or exit), umount the disks (umount -R /mnt) and reboot your computer.
<%bflib:codesnippet lang="bash">
reboot
    </%bflib:codesnippet>
TODO Talk about restoring bios settings

    <h2>User</h2>

    asdf
    <%bflib:codesnippet lang="bash">
pacman -S sudo
    </%bflib:codesnippet>

    <p>Uncomment the line <code>%wheel ALL=(ALL:ALL) ALL</code> in <code>/etc/sudoers</code>.

    <%bflib:codesnippet lang="bash">
useradd -m -G wheel -s /bin/bash <i>username</i>
    </%bflib:codesnippet>
    <%bflib:codesnippet lang="bash">
passwd <i>username</i>
    </%bflib:codesnippet>

    <h2>Snapshots</h2>
    <p>asdf</p>

    <hr>
    <p>There are still a number of things I want to understand better and add to my post:</p>
    <ul>
    <li>What about GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub?
    <li>What about further customizing grub?
    <li>Audit other mkinitcpio issues like fsck?
    </ul>

</%block>