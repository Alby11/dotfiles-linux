systemctl start sshd
echo "root:123" | chpasswd
lsblk
read -p "What device you want to use?" installDevice
installDevice="/dev/${installDevice}"
efiDevice="${installDevice}1"
rootDevice="${installDevice}2"
swapDevice="${installDevice}3"
sfdisk -l $installDevice
read -p "This will wipe the device. Continue (capital Y)?" reply
if [ ! $reply = "Y" ]
then 
  echo "Exiting..."
  exit 1
fi
vgremove -f vg_luks
blkdiscard $(installDevice)
sfdisk --delete $installDevice
echo 'start=2048, size=1048476, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B' | sfdisk /dev/vda
echo 'start=1050524, type=E6D6D379-F507-44C2-A23C-238F2A3DF928' | sfdisk -a /dev/vda
echo "write" | sfdisk --label gpt $installDevice
sfdisk --part-label $installDevice 1 boot
sfdisk --part-label $installDevice 2 luks
sfdisk --part-type $installDevice 1 C12A7328-F81F-11D2-BA4B-00A0C93EC93B
sfdisk --part-type $installDevice 2 E6D6D379-F507-44C2-A23C-238F2A3DF928
mkfs.vfat -F32 $efiDevice
cryptsetup luksFormat $rootDevice
cryptsetup luksOpen $rootDevice cryptdev
pvcreate /dev/mapper/cryptlvm
vgcreate vg_luks /dev/mapper/cryptlvm
lvcreate -L 4G vg_luks -n swap
lvcreate -l 100%FREE vg_luks -n root
mkswap /dev/mapper/vg_luks-swap
swapon /dev/mapper/vg_luks-swap
mkfs.btrfs /dev/mapper/vg_luks-root
mount /dev/mapper/vg_luks-root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots 
umount /mnt
exit 0
mkfs.btrfs -L archlinux /dev/mapper/root
mount -o compress=zstd /dev/mapper/root /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @log
btrfs subvolume create @srv
btrfs subvolume create @pkg
btrfs subvolume create @tmp
cd /
umount /mnt
mount -o compress=zstd,subvol=@ /dev/mapper/root /mnt
cd /mnt
mkdir -p {home,srv,var/{log,cache/pacman/pkg},tmp}
mount -o compress=zstd,subvol=@home /dev/mapper/root home
mount -o compress=zstd,subvol=@log /dev/mapper/root var/log
mount -o compress=zstd,subvol=@pkg /dev/mapper/root var/cache/pacman/pkg
mount -o compress=zstd,subvol=@srv /dev/mapper/root srv
mount -o compress=zstd,subvol=@tmp /dev/mapper/root tmp
mkdir -p /mnt/boot/EFI
mount $efiDevice /mnt/boot/EFI
pacman -Sy --noconfirm efivar neovim
modprobe efivarfs
pacstrap -i /mnt base base-devel grub efibootmgr dosfstools openssh os-prober mtools linux linux-headers mkinitcpio netctl dhcpcd nano neovim dialog network-manager-applet networkmanager wireless_tools wpa_supplicant linux-firmware
nvim /mnt/etc/mkinitcpio.conf
mkinitcpio -p linux
genfstab -U /mnt >> /mnt/etc/fstab
mount --bind /sys/firmware/
arch-chroot /mnt
