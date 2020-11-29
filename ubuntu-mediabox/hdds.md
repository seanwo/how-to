## Setup Media Disk Structure (Media Content) and Backup Disk

This part assumes you have an external USB drive you are going to store your media on:

```console
lsblk
```
Find disks to use for media, backup, time machine, and security (in this example it is /dev/sdb thru dev/sde)
```
sda      8:0    0 465.8G  0 disk 
└─sda1   8:1    0 465.8G  0 part /
sdb      8:16   0   7.4T  0 disk 
sdc      8:32   0   7.4T  0 disk 
sdd      8:16   0   3.7T  0 disk 
sde      8:32   0   3.7T  0 disk 
```
**Warning:** this repartions the disks; be careful!:
```console
sudo fdisk /dev/sdb
```
Use the commands g, n, w. (repeat for /dev/sdc, /dev/sdd, and /dev/sde) 

**Warning:** this formats the disk; be careful!:
```console
sudo mkfs.ext4 /dev/sdb1
sudo mkfs.ext4 /dev/sdc1
sudo mkfs.ext4 /dev/sdd1
sudo mkfs.ext4 /dev/sde1
```
Get the UUIDs of the media and backup disk:
```console
sudo blkid /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1
```
```
/dev/sdb1: UUID="6f386715-65fb-4fc1-9920-06f91a19a382" TYPE="ext4" PARTUUID="439ea135-51b8-d74d-af9a-e22c6105e2ea"
/dev/sdc1: UUID="e45c4b24-1fa2-4276-bc99-69c3c312a513" TYPE="ext4" PARTUUID="4844e889-a5d2-e241-9ab1-a9b3302ff48b"
/dev/sdd1: UUID="2a33e9ef-8ae5-4d79-9c12-025cddad6a6a" TYPE="ext4" PARTUUID="66a9ff1c-56b5-d240-9c1e-d3a76743d668"
/dev/sde1: UUID="136f3a26-7458-4cb6-821e-7d9dae89c9b2" TYPE="ext4" PARTUUID="69074da0-8583-a940-b462-ecfa6d48384b"
```
Create a mount points:
```console
sudo mkdir /mnt/media
sudo mkdir /mnt/backup
sudo mkdir /mnt/timemachine
sudo mkdir /mnt/security
```
```console
sudo vi /etc/fstab
```
add the following line (replacing it with your UUID):
```
UUID=6f386715-65fb-4fc1-9920-06f91a19a382       /mnt/media       ext4    nofail,x-systemd.device-timeout=120,acl 0       0
UUID=e45c4b24-1fa2-4276-bc99-69c3c312a513       /mnt/backup      ext4    nofail,x-systemd.device-timeout=120,acl 0       0
UUID=2a33e9ef-8ae5-4d79-9c12-025cddad6a6a       /mnt/timemachine ext4    nofail,x-systemd.device-timeout=120,acl 0       0
UUID=136f3a26-7458-4cb6-821e-7d9dae89c9b2       /mnt/security    ext4    nofail,x-systemd.device-timeout=120,acl 0       0
```
Reboot the system

Check that the drives are mounted:
```console
mount | grep /dev/sd
```
should include the following mount points:
```
/dev/sdb1 on /mnt/media type ext4 (rw,relatime)
/dev/sdc1 on /mnt/backup type ext4 (rw,relatime)
/dev/sdd1 on /mnt/timemachine type ext4 (rw,relatime)
/dev/sde1 on /mnt/security type ext4 (rw,relatime)
```
Create a media group and add our default and plex users to it:
```console
sudo addgroup media
sudo usermod -a -G media mediauser
sudo usermod -a -G media plex
```
Apply the layout:
```console
cd /mnt/media
sudo mkdir Movies
sudo mkdir Music
sudo mkdir Pictures
sudo mkdir Recorded
sudo mkdir Torrents
sudo mkdir TorrentTemp
sudo mkdir Videos
sudo chown mediauser:media Movies
sudo chown mediauser:media Music
sudo chown mediauser:media Pictures
sudo chown mediauser:media Recorded
sudo chown mediauser:media Torrents
sudo chown mediauser:media TorrentTemp
sudo chown mediauser:media Videos
sudo chmod u+rwx,g+rwxs,o+rx Movies
sudo chmod u+rwx,g+rwxs,o+rx Music
sudo chmod u+rwx,g+rwxs,o+rx Pictures
sudo chmod u+rwx,g+rwxs,o+rx Recorded
sudo chmod u+rwx,g+rwxs,o+rx Torrents
sudo chmod u+rwx,g+rwxs,o+rx TorrentTemp
sudo chmod u+rwx,g+rwxs,o+rx Videos
sudo mkdir Uploads
sudo chown root:sftp_users Uploads
sudo chmod 775 Uploads
```
```console
cd /mnt/timemachine
sudo mkdir TimeMachine
sudo chown root:tm_users TimeMachine
sudo chmod 775 TimeMachine
```
We want the following directories and files to be part of the media group regardless of who puts files in them for playback and backup purposes:
```console
cd /mnt/media
sudo setfacl -Rdm g:media:rwx Movies
sudo setfacl -Rdm g:media:rwx Music
sudo setfacl -Rdm g:media:rwx Pictures
sudo setfacl -Rdm g:media:rwx Recorded
sudo setfacl -Rdm g:media:rwx Torrents
sudo setfacl -Rdm g:media:rwx TorrentTemp
sudo setfacl -Rdm g:media:rwx Videos
```
Use bind mounts to restrict what is available via sftp and samba (windows networking).
```console
sudo vi /etc/fstab
```
add:
```
/mnt/media/Movies	/var/sftp/downloads/movies	none	defaults,bind	0	0
/mnt/media/Torrents	/var/sftp/downloads/torrents	none	defaults,bind	0	0
/mnt/media/Uploads	/var/sftp/uploads	none	defaults,bind	0	0
/mnt/media/Movies	/var/samba/movies	none	defaults,bind	0	0
/mnt/media/Torrents	/var/samba/shows	none	defaults,bind	0	0
/mnt/media/Pictures	/var/samba/pictures	none	defaults,bind	0	0
/mnt/timemachine/TimeMachine	/var/samba/timemachine	none	defaults,bind	0	0
```
