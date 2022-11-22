## Preparing Drives

You can wipe and format drives later using OMV, but I like to force the inode table and journal initialization to complete upfront and not use lazy initialization for hours afterwards.  

CLI:

List the drive device names:
```console
lsblk
```
Find disks (in this example it is /dev/sda thru dev/sdd; each are 1TB):
```
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda            8:0    0 931.5G  0 disk 
sdb            8:16   0 931.5G  0 disk 
sdc            8:32   0 931.5G  0 disk 
sdd            8:48   0 931.5G  0 disk 
mmcblk0      179:0    0  29.1G  0 disk 
├─mmcblk0p1  179:1    0   100M  0 part 
├─mmcblk0p2  179:2    0   352M  0 part /squashfs
└─mmcblk0p3  179:3    0  28.7G  0 part /
mmcblk0boot0 179:32   0     4M  1 disk 
mmcblk0boot1 179:64   0     4M  1 disk 
```
**Warning:** this repartions the disks and all data on these disks will be lost; be careful:
```console
sudo fdisk /dev/sda
```
Use the commands g, n, w.  
Repeat for /dev/sdb, /dev/sdc, and /dev/sdd.  

**Warning:** this formats the partions and all data on these disks will be lost; be careful:
```console
sudo mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/sda1
```
_Repeat for each drive_

OMV6 GUI:

Storage>File Systems>Mount
* File system: ```/dev/sd?1```
* Usage Warning Threshold: 85%
* Comment:

_Repeat for each drive_
