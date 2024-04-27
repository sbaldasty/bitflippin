<%!
    title_ = 'Installing Arch Linux on a Lenovo Thinkpad P52s'
    date_ = '2024-04-22'
    enable_custom_ = True
%>
<%def name="swiftie()"><span class="hostname">swiftie</span></%def>
<%inherit file="article.mako" />
<%namespace name="bflib" file="bflib.mako" />
<%block name="custom">
    <style>
        .hostname {
            color: green;
        }
    </style>
</%block>
<%block name="article">
    <aside>The process I present here is a patchwork of building blocks from around the internet. Some are customized. I include links along the way for attribution and further reading.</aside>

    <p>We start with the installation image already on a USB thumb drive. How to reach that point depends on what operating system we have available to download the image and restore it to the thumb drive. The <a href="https://wiki.archlinux.org/title/Installation_guide#Acquire_an_installation_image">installation image section</a> of the official guide can help. We finish when we can boot into the system as a non-root user who has internet access and can run <code>sudo</code>. Our installation has two notable features:</p>

    <ul>
    <li><p><b>Encrypted home directories.</b> We use <code>dmcrypt</code> to encrypt all home directory data at rest, meaning attackers with physical access to the laptop cannot remove the disk and read the data without getting past the encryption first. Legitimate users enter a password on startup to decrypt the home directories.</p>
    <li><p><b>Snapshot support.</b> When experimenting with software packages and configurations, reverting system changes can be daunting and error-prone. Allegedly even routine updates sometimes break the system. We use a <code>btrfs</code> partition and <code>snapper</code> to revert unwanted changes reliably.</p>
    </ul>

    <h2>Preliminaries</h2>
    <p>TODO Discuss disabling secure boot</p>
    <p>TODO Discuss selecting boot device</p>
    <p>We will need to internet connectivity for installing packages later. Assuming we have access to a wifi network, we run
    <pre>iwctl --passphrase <i>passphrase</i> station wlan0 connect <i>network</i></pre>

    <h2>Partition disk</h2>
    <p>Worth mentioning but hopefully already well understood, <strong>this process erases our entire disk</strong>. We mostly follow <a href="https://tforgione.fr/posts/arch-linux-encrypted/">Thomas Forgione's post</a> here, especially for <code>dmcrypt</code>, with the exception that we choose a <code>btrfs</code> filesystem for our root partition to support our goal of snapshotting later. The device corresponding to our disk is <code>/dev/nvme0n1</code>, but this varies across machines.</p>
    <pre>fdisk <i>diskdevice</i></pre>
    <p>We find ourselves in an interactive shell. Our tasks here are to</p>
    <ul>
    <li><p><b>Delete all existing partitions.</b> Our disk likely contains some partitions already, which we will remove. We enter <code>d</code> and accept the default partition number repeatedly, until there are no partitions left to delete.</p>
    <li><p><b>Create a boot partition.</b> Our bootloader will live here. The associated device will be <code>/dev/nvme0n1p1</code>, and we will mount it to <code>/boot/efi</code>. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting sector, and enter <code>+100M</code> for the size. If asked about removing an existing signature, we enter <code>y</code>.</p>
    <li><p><b>Create a root partition.</b> Binaries, global configuration, and logs will live here. The associated device will be <code>/dev/nvme0n1p2</code>, and we will mount it to <code>/</code>. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting sector, and enter <code>+50G</code> for the size. If asked about removing an existing signature, we enter <code>y</code>.</p>
    <li><p><b>Create a home partition.</b> User files will live here. This partition will be the largest, occupying all the remaining space on the disk. The associated device will be <code>/dev/nvme0n1p3</code>. We enter <code>n</code> to create a partition, accept the default partition number, accept the default starting cluster, and accept the default ending sector. If asked about removing an existing signature, we enter <code>y</code>.</p>
    <li><p><b>Save changes.</b> We optionally enter <code>p</code> to view our proposed changes to the partition table. We enter <code>w</code> to write these changes to the disk and exit <code>fdisk</code>.</p>
    </ul>
    <p>TODO Describe, note how some sensitive info could be outside the /home directory, note typing YES in capital letters for luksFormat, note passphrase for luksFormat...</p>
    <pre>cryptsetup luksFormat /dev/nvme0n1p3
cryptsetup luksOpen /dev/nvme0n1p3 luks_home</pre>
    <p>TODO Describe...</p>
    <pre>mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
mkfs.ext4 /dev/mapper/luks_home</pre>
    <p>TODO Describe...</p>
<pre>mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot/efi
mount --mkdir /dev/mapper/luks_home /mnt/home</pre>

    <h2>Chroot</h2>
    <p>TODO Describe... Some warnings about <i>possibly missing firmware</i> appear during the <code>mkinitcpio</code> build. We fill some of these gaps later.</p>
    <pre>pacstrap -K /mnt base linux linux-firmware</pre>
    <p>TODO Describe...</p>
    <pre>genfstab -Up /mnt >> /mnt/etc/fstab</pre>
    <p>Afterwards and optionally, if we want to see the generated <code>fstab</code> we enter
    <pre>cat /mnt/etc/fstab</pre>
    <p>TODO Describe...</p>
    <pre>arch-chroot /mnt</pre>
    <p>TODO Describe... enter same password twice for root user</p>
    <pre>passwd</pre>
Set the time zone:

<pre>
# ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
</pre>
Run hwclock(8) to generate /etc/adjtime:
<pre>
# hwclock --systohc
</pre>
Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed UTF-8 locales. Generate the locales by running:

# locale-gen

    <h2>Rebuild mkinitcpio</h2>
    <p>Since editing configuration files will be among our first priorities, we install <code>nano</code> now. Alternatively we could choose a different text editor like <code>vi</code> or <code>vim</code>.</p>
    <pre>pacman -S nano</pre>
    <p>On the line that starts with <code>HOOKS</code>, add <code>encrypt</code> between <code>block</code> and <code>filesystems</code>.</p>
    <pre>nano /etc/mkinitcpio.conf</pre>
    <p>We now rebuild the initial ramdisk.</p>
    <pre>mkinitcpio -P</pre>

    <h2>Networking</h2>
    <p>We have internet access now, but only because we booted from the installation media: <% swiftie() %> does not yet have the requisite packages for internet access, and when we eventually reboot without the installation media we will be offline. Different guides suggest different package options here, but <code>iwd</code> is contemporary and sufficient. We install <code>iwd</code> now, and will configure it when we boot into the system for the first time.</p>
    <pre>pacman -S iwd</pre>
    <p>TODO Describe...</p>
    <pre>echo <i>hostname</i> &gt; /etc/hostname</pre>
    <p>TODO Describe...</p>
    <pre>systemctl enable iwd</pre>

    <h2>Bootloader</h2>
    <pre>pacman -S grub efibootmgr</pre>
    Edit the /etc/default/grub file. The line GRUB_ENABLE_CRYPTODISK=y should be uncommented, and I also changed the GRUB_CMDLINE_LINUX line:

<pre>GRUB_CMDLINE_LINUX="cryptdevice=/dev/nvme0n1p3:luks"</pre>
Once those modifications are done (or not), you need to install the grub:

<pre>grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub
grub-mkconfig -o /boot/grub/grub.cfg</pre>

    <h2>Reboot</h2>
You can now exit the chroot (Ctrl+D or exit), umount the disks (umount -R /mnt) and reboot your computer.
<pre>reboot</pre>
TODO Talk about restoring bios settings

    <h2>Create normal user</h2>

    asdf
    <pre>pacman -S sudo</pre>
    <p>Uncomment the line <code>%wheel ALL=(ALL:ALL) ALL</code> in <code>/etc/sudoers</code>.

    <pre>useradd -m -G wheel -s /bin/bash <i>username</i></pre>
    <pre>passwd <i>username</i></pre>

    <hr>

    <ul>
    <li>What about GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub?
    <li>What about further customizing grub?
    <li>Audit other mkinitcpio issues like fsck?
    </ul>

    <h2>btrfs snapshot</h2>
</%block>