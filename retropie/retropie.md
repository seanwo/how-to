# RetroPie Instructions

## Parts List
  
* [Raspberry Pi 3 - Model B](https://www.raspberrypi.com/products/raspberry-pi-3-model-b/) $35
* [Retroflag NESPi Case Plus](https://www.amazon.com/dp/B07BRHDVTN) $20
* [Logitech G F310 Wired Gamepad Controller](https://www.amazon.com/dp/B003VAHYQY) $17
* [SAMSUNG EVO Select 128GB microSD](https://www.amazon.com/SAMSUNG-microSDXC-Nintendo-Switch-MB-ME256SA-AM/dp/B0CWPN662Q) $15
* [Crucial BX500 1TB](https://www.amazon.com/Crucial-BX500-NAND-2-5-Inch-Internal/dp/B07YD579WM) (Optional to store games on SSD)
* [UGREEN 2.5" Hard Drive Enclosure](https://www.amazon.com/gp/product/B06XWRRMYX/) $10 (Optional to store games on SSD)
* [HDMI to VGA Adapter](https://www.amazon.com/dp/B07XZ22KCD) $10 (for development purposes on old monitor)
* [PC Speakers](https://www.amazon.com/dp/B0BZCMM17X) $12 (for development purposes on old monitor)
  
## Steps

### Preparing the Hardware

Install the Raspberry Pi into the NESPI case: https://retroflag.com/download/NESPi_CASE+_Manual.pdf</br>
**Note**: *Make sure you set the SAFE SHUTDOWN switch to ON.*

### Preparing the OS

On your PC, get the Raspberry Pi Imager from https://www.raspberrypi.com/software/</br>
</br>
Select the following options in the Raspberry Pi Imager and flash the microSD card.
* Raspberry Pi Device: Raspberry Pi 3
* Operating System: Emulation and Games OS -> RetroPie -> RetroPie 4.8 (RPI 2/3/Zero 2 W) (or latest version)
* Storage: Your microSD card (be careful and choose the correct card since will wipe all data on the device)

After the card has been flashed, insert it into the Raspberry Pi.

### Initial Raspberry Pi Setup

Power up the system connected to an HDMI display.</br>
You will be prompted to configure your input device.</br>
If you have a keyboard, I suggest you configure that first.</br>
To configure subsequent devices (such as your first controller), you can always press the "start" key/button and select "configure input".</br>
</br>
Now, navigate to the RetroPie Main Menu and select "RASPI-CONFIG" and set the following options:
* System Options: hostname: [hostname] (default is: retropie)
* System Options: password: [password] (default is: raspberry)
* Localization Options: timezone: country: [timezone]
* Localization Options: WLAN country: [country]
* Interface Options: enable ssh (default is: disabled)

Exit, raspi-config, select the "start" key/button, and select quit -> restart system.

### Configure Safe Shutdown

SSH into the raspberry pi:
```console
ssh pi@retropie
```
run the following command:
```console
wget -O - "https://raw.githubusercontent.com/RetroFlag/retroflag-picase/master/install.sh" | sudo bash
```
Now, test that the button on the front of the NESPi case gracefully shuts down the system.

### Update the System

Navigate to the RetroPie Main Menu and select "RETROPIE SETUP" and select update.</br>
Say yes to all prompts including updating the OS.</br>
This will take a long time.  Once it is complete, reboot the pi.

### Setup USB drive or External SSD for Games (optional)


