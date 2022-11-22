## Install the Base OS

Get the latest installer from Axzez (Interceptor Linux OS Installer) from https://www.axzez.com/software-downloads.

Make sure you have an imaging tool like Etcher:
```console
brew install cask balenaetcher
```
Write the installer image a usb memory stick and then boot the board and CM4 module up with the usb stick.  
You can test that board and CM4 work first using a live image boot and/or you can select to install it to the eMMC.  
You will be prompted to set the admin user password during installation.  
Once the OS is installed on eMMC, shutdown, remove the usb stick and boot from eMMC.  

CLI:

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

Update the OS and Packages:
```console
sudo apt update
sudo apt full-upgrade
sudo reboot
```

Connect via SSH:
```console
ssh admin@pinas
```

Enable the root Account for Emergency Console Access.  

If you make a mistake configuring /etc/fstab (for example) you will need to resolve it via emergency console access. This requires the root account to have a password:
```console
sudo su -
passwd
exit
vi /etc/ssh/sshd_config
```
Set the root password and set the sshd configuration parameter ```PermitRootLogin``` to ```no```. 
