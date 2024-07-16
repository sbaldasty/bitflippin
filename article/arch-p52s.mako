<%!
    title_ = 'Arch Linux on a Lenovo Thinkpad P52s'
    date_ = '2024-07-10'
    enable_codesnippets_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">

    <p>I installed Arch Linux on a Lenovo Thinkpad P52s using <code>btrfs</code> for the filesystem and <code>grub</code> for the bootloader. This document contains my notes and references. It begins in a fresh installation image environment. It ends with the root user booting into the system.</p>

    <h2>Resources</h2>
    <p>I drew from several sources. The sources all have slightly different goals and focus areas. Most offer a useful generality this document may lack.</p>
    <ul>
    <li>
    <div><b><a href="https://wiki.archlinux.org/title/Installation_guide">Official installation guide</a></b></div>
    <div>Authoritative and comprehensive, but also branches off in many directions. Complimentary resources demonstrating specific paths through the installation process can help.</div>
    <li>
    <div><b><a href="https://gist.github.com/mjkstra/96ce7a5689d753e7a6bdd92cdc169bae">Michele Gementi's installation guide</a></b></div>
    <div>Primary resource after exploring many avenues because it treats an unencrypted <code>btrfs</code> filesystem. Concludes with a discussion of video drivers and preparation for playing games.</div>
    <li>
    <div><b><a href="https://tforgione.fr/posts/arch-linux-encrypted/">Thomas Forgione's installation guide</a></b></div>
    <div>Uses <code>ext4</code> filesystems, but features an encrypted <code>/home</code> partition. Discusses <code>docker</code> configuration, and measures to ensure the compatibility of the installation with wake-on-lan.</div>
    <li><div><b><a href="https://gist.github.com/myyc/9595b520a4c564bef8143a86582f1ea1">Myyc's installation guide</a></b></div>
    <div>Single encrypted <code>btrfs</code> filesystem. Built in <code>systemd</code> bootloader instead of <code>grub</code>. Splash screen on startup and shutdown using <code>plymouth</code>. Covers setting up secure boot and hibernate.</div>
    <li><div><b><a href="https://phoenixnap.com/kb/linux-commands-check-memory-usage">Vladimir Kaplarevic's swap post</a></b></div>
    <div>Discusses swap partitions and the practices surrounding them that several major Linux distributions have landed on. Also contains useful information about memory usage and monitoring.</div>
    <li><div><b><a href="https://forum.osdev.org/viewtopic.php?t=33029">Brendan and others on the initial ramdisk</a></b></div>
    <div>Flow of control passes through a <i>bootloader</i> and an <i>initial ramdisk</i> before reaching the Linux kernel. Contributors discuss and critique why these components exist and what they do.</div>
    </ul>

    <h2>Partitions</h2>
    <p>Hopefully already well understood, but always worth mentioning, these instructions delete all data on the disk. Device names may vary by system.</p>
    <%bflib:codesnippet lang="bash">
fdisk /dev/nvme0n1
    </%bflib:codesnippet>
    <p>The <code>fdisk</code> utility launches. It presents an interactive prompt.</p> 
    <ul>
    <li><p><b>Delete any existing partitions.</b> Enter <kbd>d</kbd> and accept the default partition repeatedly until no partitions remain.</p>
    <li><p><b>Create EFI partition.</b> Enter <kbd>n</kbd> to create a new partition. Enter <kbd>1</kbd> for the <i>partition number</i>. Accept the default <i>first sector</i>. Enter <kbd>+4G</kbd> for the <i>size</i>. Then <code>fdisk</code> returns to its top-level prompt. Enter <kbd>t</kbd> to set the partition type. Enter <kbd>1</kbd> for the <i>partition number</i>. Enter <kbd>uefi</kbd> for the <i>partition type</i>.</p>
    <li><p><b>Create root partition.</b> Enter <kbd>n</kbd> to create a new partition. Enter <kbd>2</kbd> for the <i>partition number</i>. Accept the default <i>first sector</i>. Accept the default <i>size</i> to use all remaining disk space.</p>
    <li><p><b>Write changes.</b> Optionally enter <kbd>p</kbd> to display the changes. Enter <kbd>w</kbd> to write the changes to disk. Then <code>fdisk</code> exits automatically.</p>
    </ul>
    <p>Two new devices <code>/dev/nvme0np1</code> and <code>/dev/nvme0np1</code> exist now, and correspond to the two new partitions.</p>

    <h2>Filesystems</h2>
    <p>Format the root partition with a <code>btrfs</code> filesystem to support snapshots. Ultimately only the subvolumes of this partition will be mounted, but for now temporarily mount it for the purpose of creating the subvolumes. Good candidates are parts of the filesystem that contain large or rapidly changing data unimportant for system restoration purposes. Create the subvolumes. The subvolumes appear under the partition's mount point as directories. Unmount the partition. Mount each of the subvolumes in its proper place. The <code>noatime</code> option improves performance by not tracking access times on files.</p>
    <%bflib:codesnippet lang="bash">
# Format the root partition
mkfs.btrfs /dev/nvme0n1p2

# Mount the partition temporarily
mount /dev/nvme0n1p2 /mnt

# Create subvolumes in the partition
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@root_btrsnap
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@var_cache
btrfs su cr /mnt/@var_log
btrfs su cr /mnt/@var_tmp

# Umount the partition
umount /mnt

# Mount the subvolumes
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@ /dev/nvme0n1p2 /mnt
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@home /dev/nvme0n1p2 /mnt/home
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@root_btrsnap /dev/nvme0n1p2 /mnt/root/btrsnap
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@tmp /dev/nvme0n1p2 /mnt/tmp
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@var_cache /dev/nvme0n1p2 /mnt/var/cache
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@var_log /dev/nvme0n1p2 /mnt/var/log
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@var_tmp /dev/nvme0n1p2 /mnt/var/tmp
    </%bflib:codesnippet>
    <p>Format the EFI parition with a FAT32 filesystem for compatibility with the firmware that will need to interact with it, and then mount the partition. The <code>fmask</code> and <code>dmask</code> options may help prevent certain nondescript boot issues I encountered.</p>
    <%bflib:codesnippet lang="bash">
mkfs.vfat -F32 /dev/nvme0n1p1
mount --mkdir -o fmask=0077,dmask=0077 /dev/nvme0n1p1 /mnt/efi
    </%bflib:codesnippet>

    <h2>Installation</h2>
    <p>Connect to the internet wirelessly, replacing <kbd>MyNetwork</kbd> and <kbd>MyPassphrase</kbd> appropriately. Install the minimum necessary packages. Generate the <code>fstab</code> file. This file remembers where we mounted everything.</p>
    <%bflib:codesnippet lang="bash">
iwctl --passphrase MyPassphrase station wlan0 connect MyNetwork
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# Optionally take a snapshot
btrfs su snapshot /mnt /mnt/root/btrsnap/0000.base
    </%bflib:codesnippet>


    <h2>Configuration</h2>
    <p>Enter into the new installation. Install <code>iwd</code> for internet access without help from the installation image, the text editor <code>vim</code> for editing configuration files, and <code>btrfs-progs</code> for taking system snapshots. Go through a number of mundane steps per the installation guide.</p>
    <%bflib:codesnippet lang="bash">
arch-chroot /mnt
pacman -S iwd vim btrfs-progs

# Set root password
passwd

# Create /etc/localtime (replace MyRegion and MyCity appropriately)
ln -sf /usr/share/zoneinfo/MyRegion/MyCity /etc/localtime

# I didn't read up on what this does
hwclock --systohc

# Uncomment the appropriate UTF-8 line, generate locale(s)
vim /etc/locale.gen
locale-gen
    </%bflib:codesnippet>

    <h2>Bootloader</h2>
    <p>Install the necessary packages to make a <code>grub</code> bootloader. Then install the bootloader and set up its configuration. Consider saving the bootloader installation and configuration lines as a script for later use.</p>
    <%bflib:codesnippet lang="bash">
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=arch_grub
grub-mkconfig -o /boot/grub/grub.cfg

# Optionally take a snapshot
btrfs su snapshot / /root/snapshots/0001.configure
    </%bflib:codesnippet>

    <h2>Reboot</h2>
    <p>Exit out of the <code>chroot</code>, unmount all the filesystems, and restart the system.</p>
    <%bflib:codesnippet lang="bash">
# Back in the installation image environment
umount -R /mnt
reboot
    </%bflib:codesnippet>
    <p>Remove the installation media and restart the laptop. If all goes well log in as <kbd>root</kbd>.</p>
</%block>