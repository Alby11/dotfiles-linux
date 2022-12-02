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
umount /mnt/
swapoff -a
partx $installDevice
for i in $(vgs | grep -v 'VG' | cut -d ' ' -f 3)
do
  vgremove -f $i
done
for i in $(pvs | grep -v 'PV' | cut -d ' ' -f 3)
do
  pvremove -f $i
done
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
pvcreate /dev/mapper/cryptdev
vgcreate vg_luks /dev/mapper/cryptdev
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
