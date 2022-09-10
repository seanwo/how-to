## Raspberry Pi NAS 

Parts List:
* [Raspberry Pi 4 Compute Module (CM4) 4GB RAM 32GB eMMC (CM4004032)](https://shopping.google.com/search?q=CM4004032) $110
* [Interceptor Carrier Board](https://www.axzez.com/product-page/interceptor-carrier-board) $119
* [Hard Drive Cage](https://www.amazon.com/dp/B0854QRSC2) $27
* [Noctua NF-S12B Redux-700](https://www.amazon.com/dp/B00L8IYCJI) $14
* [Noctua NA-SAVP1 Anti-Vibration Pads for 120/140mm Fans (16-Pack, Grey)](https://www.amazon.com/dp/B07SWRXT3D) $9
* [RGEEK 24pin PSU 12V DC Input 150W Peak Output Switch DC-DC ATX Pico PSU Mini ITX PC Power](https://www.amazon.com/dp/B07WDG49S8) $26
* [AC 100-240V to DC 12V 10A Power Supply Adapter 12V 10A 120W 5.5mm x 2.5-2.1mm Jack](https://www.amazon.com/dp/B07MXXXBV8) $21
* [Aluminum Alloy Heatsink with PWM Fan for Raspberry Pi Compute Module 4](https://www.amazon.com/dp/B092PMY7RC) $11
* [Noctua NF-A4x10 FLX](https://www.amazon.com/dp/B009NQLT0M) $14 * 2 = $28
* [SilverStone Technology CP06-E4 Super Flexible 4-in-1 SATA Power Adapter Cable with Power Stabilizing Capacitors](https://www.amazon.com/dp/B07KT992G2) $14
* [CableCreation SATA III Cable, [5-Pack] 18-inch SATA III 6.0 Gbps](https://www.amazon.com/dp/B01IBA3ITK) $10
* [Up Angled USB 2.0 Type-A Male to Female Extension Data Flat Slim FPC Cable 20cm](https://www.amazon.com/dp/B094Y293ZM) $9
* [Up Angled Standard HMMI Male to Female Extension Data Flat Slim FFC FPV Cable 20cm](https://www.amazon.com/dp/B07BWG2XT5) $18
* [COMeap (2-Pack) 4 Pin to SATA Female Hard Drive Power Adapter Cable 19cm](https://www.amazon.com/dp/B07JHBJWD4) $11 (DO NOT USE WITHOUT SWITCHING PINS!)
* [Hammond Enclosure 140x140x60mm (1554QGY)](http://tinyurl.com/2p8vmdeu) $18

Notes:
* You will need to drill the holes deeper on one of the 40mm Noctua fans in order to mount it to the Heatsink with the original screws.  Just use the appropriate drill bit and run the drill in reverse to slowly wear away the plastic in the mounting holes to the proper depth
* You will need to re-pin Pico PSU side of the the replacement SATA power cable if you use it (instead of the one that came with the Pico PSU)  If you do not re-pin it, YOU WILL DESTROY ANY HARD DRIVE YOU PLUG INTO IT

### Install the Base OS

Get the latest installer from Axzez (Interceptor Linux OS Installer) from https://www.axzez.com/software-downloads

Make sure you have an imaging tool like Etcher
```console
brew install cask balenaetcher
```
Write the installer image a usb memory stick and then boot the board and CM4 module up with the usb stick  
You can test that board and CM4 work first using a live image boot and/or you can select to install it to the eMMC  
You will be prompted to set the admin user password during installation  
Once the OS is installed on eMMC, shutdown, remove the usb stick and boot from eMMC  

### Configure the Device Network and Update the OS and Packages

When booting up make sure you plug the network into ethernet port A  
Get the mac address of the Network Interface  
```console
sudo ifconfig
```
Create an IP reserveration for the mac address in your router (optional)  
Rename the device to ```pinas```  
```console
sudo vi /etc/hostname
```
Update the OS and OS packages  
```console
sudo apt update
sudo apt full-upgrade
sudo apt reboot
```

### Connect to the Device via SSH

```console
ssh admin@pinas
```

###  Enable the root Account for Emergency Console Access

If you make a mistake configuring /etc/fstab later you will need to solve it via emergency console access  
This requires the root account to have a password  
```console
sudo su -
passwd
vi /etc/ssh/sshd_config
```
Set the root password and set the sshd configuration parameter ```PermitRootLogin``` to ```no```  

### Install OMV

You will need wget to get and then run the OMV installer script  
```console
sudo apt install wget
```
Install OMV  
```console
wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install | sudo bash
sudo reboot
```
Note: This did not completely install for me the first time. It looked like it completed but the web interface was not available after the reboot. So I repeated the step above and it worked the second time around.  Possible dependency problem.  
  
Make sure everything is up-to-date again  
```console
sudo apt update
sudo apt full-upgrade
sudo apt reboot
```

Hopefully, you can now access OMV on http://pinas  

