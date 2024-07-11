<%!
    title_ = 'Arch Linux on a Lenovo Thinkpad P52s'
    date_ = '2024-07-10'
    enable_codesnippets_ = True
%>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="article">

    <p>I installed Arch Linux on a Lenovo Thinkpad P52s using <code>grub</code> for the bootloader and <code>btrfs</code> for the filesystem. This document contains my notes and references from that project. It begins in the installation image environment. It ends with the root user booting into the system. As always please exercise caution.</p>

    <h2>Resources</h2>
    <p>I drew from many sources. The sources all have slightly different goals and areas of focus. Many offer a useful generality this document may lack.</p>
    <ul>
    <li><p><b><a href="https://wiki.archlinux.org/title/Installation_guide">Official installation guide.</a></b> asdf</p>
    <li><p><b><a href="https://gist.github.com/mjkstra/96ce7a5689d753e7a6bdd92cdc169bae">Michele Gementi's installation guide.</a></b> asdf</p>
    <li><p><b><a href="https://tforgione.fr/posts/arch-linux-encrypted/">Thomas Forgione's installation guide.</a></b> asdf</p>
    <li><p><b><a href="https://phoenixnap.com/kb/linux-commands-check-memory-usage">Vladimir Kaplarevic's swap post.</a></b> asdf</p>
    <li><p><b><a href="https://gist.github.com/myyc/9595b520a4c564bef8143a86582f1ea1">Myyc's installation guide.</a></b> asdf</p>
    <li><p><b><a href="https://forum.osdev.org/viewtopic.php?t=33029">Brendan and others on the initial ramdisk.</a></b> asdf</p>
    </ul>

    <h2>Partitions</h2>
    <p>Hopefully well understood, but always worth mentioning, these instructions delete all data on the disk. Note device names may vary by system.</p>
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
    <p>Give <code>/dev/nvme0n1p1</code> a FAT32 filesystem for compatibility with the firmware that will need to interact with it. Give <code>/dev/nvme0np1</code> a <code>btrfs</code> filesystem.</p>
    <%bflib:codesnippet lang="bash">
mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
    </%bflib:codesnippet>
    <p>Mount the filesystems. The <code>fmask</code> and <code>dmask</code> options may help prevent certain nondescript boot issues I encountered.</p>
    <%bflib:codesnippet lang="bash">
mount /dev/nvme0n1p2 /mnt
    </%bflib:codesnippet>
    <p>Create subvolumes in the root partition to exclude certain directories from root snapshots. Candidates may include directories with typically large or rapidly changing data unimportant for system restoration purposes.</p>
    <%bflib:codesnippet lang="bash">
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@root_btrsnap
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@var_cache
btrfs su cr /mnt/@var_log
btrfs su cr /mnt/@var_tmp
    </%bflib:codesnippet>
    <p>Unmount the main <code>btrfs</code> filesystem.
    <%bflib:codesnippet lang="bash">
umount /mnt
    </%bflib:codesnippet>
    <p>Mount the subvolumes to their respective places. The <code>noatime</code> option improves performance by not tracking access times on files.</p>
    <%bflib:codesnippet lang="bash">
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@ /dev/nvme0n1p2 /mnt
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@home /dev/nvme0n1p2 /mnt/home
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@root_btrsnap /dev/nvme0n1p2 /mnt/root/btrsnap
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@tmp /dev/nvme0n1p2 /mnt/tmp
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@var_cache /dev/nvme0n1p2 /mnt/var/cache
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@var_log /dev/nvme0n1p2 /mnt/var/log
mount --mkdir -o noatime,compress=lzo,space_cache=v2,subvol=/@var_tmp /dev/nvme0n1p2 /mnt/var/tmp
    </%bflib:codesnippet>
    <p>Mount the EFI partition.</p>
    <%bflib:codesnippet lang="bash">
mount --mkdir -o fmask=0077,dmask=0077 /dev/nvme0n1p1 /mnt/efi
    </%bflib:codesnippet>

    <h2>Installation</h2>
    <p>Connect to the internet wirelessly, replacing <kbd>MyNetwork</kbd> and <kbd>MyPassphrase</kbd> appropriately.</p>
    <%bflib:codesnippet lang="bash">
iwctl --passphrase MyPassphrase station wlan0 connect MyNetwork
    </%bflib:codesnippet>
    <p>Install the minimum necessary packages. Also install <code>iwd</code> for internet access without help from the installation image, the text editor <code>vim</code> for editing configuration files, and <code>btrfs-progs</code> for taking system snapshots.</p>
    <%bflib:codesnippet lang="bash">
pacstrap -K /mnt base linux linux-firmware
    </%bflib:codesnippet>
    <p>Generate the <code>fstab</code> file. This file remembers where all the volumes are mounted.</p>
    <%bflib:codesnippet lang="bash">
genfstab -U /mnt >> /mnt/etc/fstab
    </%bflib:codesnippet>
    <p>Optionally take a snapshot.</p>
    <%bflib:codesnippet lang="bash">
btrfs su snapshot /mnt /mnt/root/btrsnap/0000.base
    </%bflib:codesnippet>
    <p>Enter into the new installation.</p>
    <%bflib:codesnippet lang="bash">
arch-chroot /mnt
    </%bflib:codesnippet>
    <p>Install other packages.</p>
    <%bflib:codesnippet lang="bash">
pacman -S iwd vim btrfs-progs
    </%bflib:codesnippet>

    <h2>Configuration</h2>
    <p>Set a password for the root user.</p>
    <%bflib:codesnippet lang="bash">
passwd
    </%bflib:codesnippet>
    <p>Link <code>localtime</code> to the correct file, replacing <code>MyRegion</code> and <code>MyCity</code> as appropriate.</p>
    <%bflib:codesnippet lang="bash">
ln -sf /usr/share/zoneinfo/MyRegion/MyCity /etc/localtime
    </%bflib:codesnippet>
    <p>Generate the <code>adjtime</code> file per the installation guide.</p>
    <%bflib:codesnippet lang="bash">
hwclock --systohc
    </%bflib:codesnippet>
    <p>Edit <code>locale.gen</code>, uncommenting the appropriate <code>UTF-8</code> line. Generate the locales.</p>
    <%bflib:codesnippet lang="bash">
vim /etc/locale.gen
locale-gen
    </%bflib:codesnippet>

    <h2>Bootloader</h2>
    <p>Install the necessary packages to make a <code>grub</code> bootloader.</p>
    <%bflib:codesnippet lang="bash">
pacman -S grub efibootmgr
    </%bflib:codesnippet>
    <p>Install the bootloader and set up its configuration.</p>
    <%bflib:codesnippet lang="bash">
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=arch_grub
grub-mkconfig -o /boot/grub/grub.cfg
    </%bflib:codesnippet>
    <p>Optionally take a snapshot.</p>
    <%bflib:codesnippet lang="bash">
btrfs su snapshot / /root/snapshots/0001.configure
    </%bflib:codesnippet>

    <h2>Reboot</h2>
    <p>Exit out of the <code>chroot</code>.</p>
    <%bflib:codesnippet lang="bash">
exit
    </%bflib:codesnippet>
    <p>Unmount all the filesystems.</p>
    <%bflib:codesnippet lang="bash">
umount -R /mnt
    </%bflib:codesnippet>
    <p>Restart the system. If all goes well, log in again as <kbd>root</kbd></p>
    <%bflib:codesnippet lang="bash">
reboot
    </%bflib:codesnippet>
</%block>