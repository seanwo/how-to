## Install the Base OS

source: https://pimylifeup.com/raspberry-pi-update/  

### Write the OS Image to the SD Card

Goto https://www.raspberrypi.com/software/ and get the imager tool or use brew to install it.

```console
brew install raspberry-pi-imager
```

Run the tool and select:  
* Operating System: Raspberry Pi OS (other) -> Raspberry Pi OS Lite (32-bit). 
* Storage: Select your microSD card. 
* Settings:  
   * Set hostname: tinypilot. 
   * Enable SSH: Use password authentication. 
   * Set username and password: tinypilot/[secure password]. 
   * Set lcoale settings: Time zone: [your time zone]. 
* Select Write to image the card.  

Put the card in the raspberry pi and boot it up on the network.  
Check your router for the ip address that it aquired.  Optionally assign the mac address to a reserved dhcp ip address and cname it to tinypilot.  

### Update the OS and packages

```console 
ssh tinypilot@tinypilot
```

```console
sudo apt update
sudo apt full-upgrade
sudo reboot
```
### Update the bootloader

SSH into the device:
```console 
ssh tinypilot@tinypilot
```

Check if the bootloader is up-to-date:  
```console
sudo rpi-eeprom-update
```

If the bootloader is not up-to-date:  
```console
sudo rpi-eeprom-update -a
sudo reboot
```
