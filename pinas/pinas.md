## Raspberry Pi NAS 

![alt text](cover.on.small.gif "pinas")

### Parts Needed

Parts list:
* [Raspberry Pi 4 Compute Module (CM4) 4GB RAM 32GB eMMC (CM4004032)](https://shopping.google.com/search?q=CM4004032) $110
* [Interceptor Carrier Board](https://www.axzez.com/product-page/interceptor-carrier-board) $119
* [Hard Drive Cage](https://www.amazon.com/dp/B0854QRSC2) $27
* [Noctua NF-S12B Redux-700](https://www.amazon.com/dp/B00L8IYCJI) $14
* [Noctua NA-SAVP1 Anti-Vibration Pads for 120/140mm Fans (16-Pack, Grey)](https://www.amazon.com/dp/B07SWRXT3D) $9 (optional)
* [RGEEK 24pin PSU 12V DC Input 150W Peak Output Switch DC-DC ATX Pico PSU Mini ITX PC Power](https://www.amazon.com/dp/B07WDG49S8) $26
* [AC 100-240V to DC 12V 10A Power Supply Adapter 12V 10A 120W 5.5mm x 2.5-2.1mm Jack](https://www.amazon.com/dp/B07MXXXBV8) $21
* [Aluminum Alloy Heatsink with PWM Fan for Raspberry Pi Compute Module 4](https://www.amazon.com/dp/B092PMY7RC) $11
* [Noctua NF-A4x10 FLX](https://www.amazon.com/dp/B009NQLT0M) $14 * 2 = $28
* [SilverStone Technology CP06-E4 Super Flexible 4-in-1 SATA Power Adapter Cable with Power Stabilizing Capacitors](https://www.amazon.com/dp/B07KT992G2) $14
* [CableCreation SATA III Cable, [5-Pack] 18-inch SATA III 6.0 Gbps](https://www.amazon.com/dp/B01IBA3ITK) $10
* [Up Angled USB 2.0 Type-A Male to Female Extension Data Flat Slim FPC Cable 20cm](https://www.amazon.com/dp/B094Y293ZM) $9 (optional; recommended)
* [Up Angled Standard HMMI Male to Female Extension Data Flat Slim FFC FPV Cable 20cm](https://www.amazon.com/dp/B07BWG2XT5) $18 (optional; recommended)
* [COMeap (2-Pack) 4 Pin to SATA Female Hard Drive Power Adapter Cable 19cm](https://www.amazon.com/dp/B07JHBJWD4) $11 (optional)
* [Hammond Enclosure 140x140x60mm (1554QGY)](http://tinyurl.com/2p8vmdeu) $18

Assembly Notes:
* You will need to drill the holes deeper on one of the 40mm Noctua fans in order to mount it to the Heatsink with the original screws.  Just use the appropriate drill bit and run the drill in reverse to slowly wear away the plastic in the mounting holes to the proper depth.
* You will need to re-pin Pico PSU side of the the replacement SATA power cable if you use it (instead of the one that came with the Pico PSU)  If you do not re-pin it, YOU WILL DESTROY ANY HARD DRIVE YOU PLUG INTO IT.

### Install the Base OS

Get the latest installer from Axzez (Interceptor Linux OS Installer) from https://www.axzez.com/software-downloads.

Make sure you have an imaging tool like Etcher:
```console
brew install cask balenaetcher
```
Write the installer image a usb memory stick and then boot the board and CM4 module up with the usb stick.  
You can test that board and CM4 work first using a live image boot and/or you can select to install it to the eMMC.  
You will be prompted to set the admin user password during installation.  
Once the OS is installed on eMMC, shutdown, remove the usb stick and boot from eMMC.  

### Configure the Network

When booting up make sure you plug the network into ethernet port A.  
Get the mac address of the Network Interface:
```console
sudo ifconfig
```
Create an IP reservation for the mac address in your router (optional)  
Rename the device to ```pinas```:
```console
sudo vi /etc/hostname
sudo vi /etc/hosts
sudo sync; sudo reboot
```

### Update the OS and Packages  

```console
sudo apt update
sudo apt full-upgrade
sudo reboot
```

### Connect via SSH

```console
ssh admin@pinas
```

###  Enable the root Account for Emergency Console Access

If you make a mistake configuring /etc/fstab (for example) you will need to resolve it via emergency console access. This requires the root account to have a password:
```console
sudo su -
passwd
exit
vi /etc/ssh/sshd_config
```
Set the root password and set the sshd configuration parameter ```PermitRootLogin``` to ```no```.  

Hopefully, you can now access OMV on http://pinas.  

### Install hd-idle

Many older drivers can not be set to spin down on a timer with hdparm so the solution is keep the spindown disabled in OMV and use hd-idle to spin your drive down while not in use.  If you are setting up an active RAID, you don't want to do this but I plan on using SnapRAID and I want my drives spun down as much as possible to keep the noise levels low.  

Installing the latest hd-idle package:
```console
sudo apt install wget
sudo apt install lsb-release
wget -O -  http://adelolmo.github.io/andoni.delolmo@gmail.com.gpg.key | sudo apt-key add -
echo "deb http://adelolmo.github.io/$(lsb_release  -cs) $(lsb_release -cs) main" | sudo tee  /etc/apt/sources.list.d/adelolmo.github.io.list
sudo apt update
sudo apt install hd-idle
```
Edit the hd-idle configuration file:
```console
sudo vi /etc/default/hd-idle
```
Make the following changes:
```
START_HD_IDLE=true
HD_IDLE_OPTS="-i 300 -l /var/log/hd-idle.log"
```
Set hd-idle to run as a service:
```console
sudo systemctl unmask hd-idle
sudo systemctl start hd-idle
sudo systemctl enable hd-idle
```

### Manually Formatting Hard Drives (Optional)

List the drive device name:
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
Use the commands g, n, w. (repeat for /dev/sdb, /dev/sdc, and /dev/sdd).  

**Warning:** this formats the partions and all data on these disks will be lost; be careful:
```console
sudo mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/sda1
sudo mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/sdb1
sudo mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/sdc1
sudo mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/sdd1
```

### Install OMV

You will need wget to get and then run the OMV installer script:
```console
sudo apt install wget
```
Run the OMV installation script.  
```console
wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install | sudo bash
sudo sync; sudo reboot
```
Note: This did not completely install for me the first time. It looked like it completed but the web interface was not available after the reboot. So I repeated the step above and it worked the second time around.  Possible dependency problem.  
  
Make sure everything is up-to-date again:
```console
sudo apt update
sudo apt full-upgrade
sudo sync; sudo reboot
```

In order for network discovery (avahi-daemon) to work properly (with the interceptor board) you need to make it aware of the "wan" VLAN.
```console
sudo omv-env set -- OMV_AVAHIDAEMON_ALLOW_INTERFACES "wan"
sudo omv-salt stage run prepare
sudo omv-salt stage run deploy
```

### Setup a Network UPS Tool (NUT) Client

I have a Network UPS Tool (NUT) Server running on a [Raspberry Pi Management Server](/tinypilot/tinypilot.md#install-network-ups-tools) that monitors the UPS that this NAS is plugged into.  I want to setup a NUT client on this NAS to be informed when to shutdown during the low power warning.

System->Plugins->Search->```openmediavault-nut```->Install  
Services->UPS:
```
Enabled: true
Identifier: apc-server
Comment:
Netclient hostname: 192.168.###.###
Netclient user name: admin
Netclient password: secret
Powervalue: 1
Shutdown mode: UPS reaches low battery
```

NOTE: set ```Identifier``` to the name/identifier of the NUT server.  
NOTE: set ```Netclient hostname``` to the actual ip address of the NUT server.  
NOTE: set ```Netclient password``` to the actual secret you used on the NUT server.  

I don't want the NAS to control shutting down the UPS itself so we have to alter a configuration file vi an OVM environment variable:
```console
sudo omv-env set -- OMV_UPSMON_POWERDOWNFLAG "/dev/null"
sudo omv-salt stage run prepare
sudo omv-salt stage run deploy
```

### Install Utilities (Optional)

Install IOTop in case you want to monitor the device IO performance:
```console
brew install iotop
```

Install IPerf3 in case you want to run a network performance test:
```console
brew install iperf3
```

Create shell script to get the CPU temperature:
```console
vi ~/gettemp.sh
```

```
#!/bin/bash
/usr/bin/vcgencmd measure_temp
```

```console
chmod +x ~/gettemp.sh
```
