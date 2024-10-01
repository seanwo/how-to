# RetroPie Instructions

![alt text](nespi.case.jpg "retropie")

## Parts List
  
* [Raspberry Pi 3 - Model B](https://www.raspberrypi.com/products/raspberry-pi-3-model-b/) $35
* [Retroflag NESPi Case Plus](https://www.amazon.com/dp/B07BRHDVTN) $20
* [8Bitdo Ultimate 2C Wired Controller](https://www.amazon.com/dp/B003VAHYQY) $20
* [SAMSUNG EVO Select 128GB microSD](https://www.amazon.com/SAMSUNG-microSDXC-Nintendo-Switch-MB-ME256SA-AM/dp/B0CWPN662Q) $15
* [Crucial BX500 1TB](https://www.amazon.com/Crucial-BX500-NAND-2-5-Inch-Internal/dp/B07YD579WM) $65 (Optional to store games on SSD)
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

source: https://retropie.org.uk/docs/Running-ROMs-from-a-USB-drive/<br>

Basically, format your SSD as exFat, place folder on it called "retropie-mount", boot your raspberry pi up with the drive plugged in, wait for the drive to stop flashing and it will be initialized for games.

### RetroPie Packages

RetroPi has the following packages it uses: core, main, opt (optional) and exp (experimental). Core packages are basically the RetroPi UI and drivers. Main packages are the emulators it installs by default. Optional packages are alternative emulators to the ones in the main packages and/or extra emulators you can install.  Experimental packages extend the optional packages but are less likely to be stable.</br>
</br>
Each emulator can be a snowflake on what is needed to get ROMs (games) running on them.  The next section covers my adventures and choices for running ROMS and ports on selected emulators.  Your decisions may vary.

### Emulators

In the package manager, remove the following main (arcade) packages:

* lr-fbneo
* lr-mame2003

Add the following optional & experimental (replacment) packages:

* coolcv (optiona)
* lr-freechaf (experimental)

Here are the notes for configuring the packages, getting roms, and BIOS files:

| directory | rp_module_id | roms | bios | bios.name | bios.source | setup notes |
| --------- | ------------ | ---- | ---- | --------- | ----------- | ----------- |
| amstradcpc | lr-caprice32 | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Amstrad%20-%20CPC.zip | none |  |  | use start+Y for virtual keyboard |
| atari2600 | lr-stella2014 | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Atari%20-%202600.zip | none |  |  |  |
| atari5200 | lr-atari800 | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Atari%20-%205200.zip | required | 5200.rom | [BIOS] Atari 5200 (USA).zip | https://youtu.be/u2nj73mNgAE?si=-mP15IKaJIe7Dvoj</br>https://youtu.be/D8eZDq3xyBA?si=ZA8AogZAAm8ot4LU |
| atari7800 | lr-prosystem | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Atari%20-%207800.zip | optional | 7800 BIOS (U).rom | [BIOS] Atari 7800 (USA).zip |  |
| atarilynx | lr-handy | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Atari%20-%20Lynx.zip | optional | lynxboot.img | [BIOS] Atari Lynx (USA, Europe).zip |  |
| channelf | lr-freechaf | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Fairchild%20-%20Channel%20F.zip | required | sl31253.bin</br>sl31254.bin</br>sl90025.bin | [BIOS] Fairchild Channel F (USA) (SL31253).zip</br>[BIOS] Fairchild Channel F (USA) (SL31254).zip</br>[BIOS] Fairchild Channel F (USA) (SL90025).zip |  |
| coleco | coolcv | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Coleco%20-%20ColecoVision.zip | none |  |  | requires real keyboard |
| fds | lr-nestopia | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Nintendo%20Entertainment%20System.zip | required | disksys.rom | [BIOS] Family Computer Disk System (Japan) (Rev 1).zip |  |
| gamegear | lr-genesis-plus-gx | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Sega%20-%20Game%20Gear.zip | optional | bios.gg | [BIOS] Sega Game Gear (USA) (Majesco).zip |  |
| gb | lr-gambatte | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Game%20Boy.zip | optional | gb_bios.bin | [BIOS] Nintendo Game Boy Boot ROM (World) (Rev 1).zip |  |
| gba | lr-mgba | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Game%20Boy%20Advance.zip | optional | gba_bios.bin | [BIOS] Game Boy Advance (World).zip |  |
| gbc | lr-gambatte | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Game%20Boy%20Color.zip | optional | gbc_bios.bin | [BIOS] Nintendo Game Boy Color Boot ROM (World) (Rev 1).zip |  |
| mastersystem | lr-genesis-plus-gx | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Sega%20-%20Master%20System%20-%20Mark%20III.zip | optional | bios_E.sms</br>bios_J.sms</br>bios_U.sms | [BIOS] Sega Master System (USA, Europe) (v1.3).zip</br>[BIOS] Sega Master System (Japan) (v2.1).zip</br>[BIOS] Sega Master System (USA, Europe) (v1.3).zip |  |
| megadrive | lr-genesis-plus-gx | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Sega%20-%20Mega%20Drive%20-%20Genesis.zip | optional | bios_MD.bin | [BIOS] Sega Mega Drive - Genesis Boot ROM (World).zip |  |
| n64 | mupen64plus | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Nintendo%2064.zip | none |  |  | uncompress all .zip files to .z64 |
| nes | lr-fceumm | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Nintendo%20Entertainment%20System.zip | optional |  |  | no roms needed for nes; only fds |
| ngp | lr-beetle-ngp | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/SNK%20-%20Neo%20Geo%20Pocket.zip | none |  |  |  |
| ngpc | lr-beetle-ngp | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/SNK%20-%20Neo%20Geo%20Pocket%20Color.zip | none |  |  |  |
| pcengine | lr-beetle-supergrafx | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/NEC%20-%20PC%20Engine%20SuperGrafx.zip | required | syscard3.pce | [BIOS] Super CD-ROM System (Japan) (v3.0).zip | make lr-beetle-supergrafx default engine |
| psx | lr-pcsx-rearmed | https://archive.org/download/chd_psx/CHD-PSX-USA/ | required | psxonpsp660.bin & scph101.bin & scph7001.bin & scph5501.bin & scph1001.bin | https://github.com/Abdess/retroarch_system/tree/libretro/Sony%20-%20PlayStation | |
| sega32x | lr-picodrive | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Sega%20-%2032X.zip | none |  |  |  |
| segacd | lr-genesis-plus-gx | no games; add on periphal | required | bios_CD_U.bin</br>bios_CD_E.bin</br>bios_CD_J.bin | [BIOS] Sega CD (USA) (Rev B).zip</br>[BIOS] Mega-CD (Europe).zip</br>[BIOS] Mega-CD (Asia) (Ja) (Rev H).zip |  |
| sg-1000 | lr-genesis-plus-gx | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Sega%20-%20SG-1000.zip | none |  |  |  |
| snes | lr-snes9x2010 | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/Nintendo%20-%20Super%20Nintendo%20Entertainment%20System.zip | required (satellaview) | BS-X.bin | https://archive.org/download/bsx-bios | uncompress satellaview from .zip to .bs |
| vectrex | lr-vecx | https://archive.org/download/hearto-1g1r-collection/hearto_1g1r_collection/GCE%20-%20Vectrex.zip | none |  |  |  |
| zxspectrum | lr-fuse | https://myrient.erista.me/files/TOSEC/Sinclair/ZX%20Spectrum/Games/%5BZ80%5D/Sinclair%20ZX%20Spectrum%20-%20Games%20-%20%5BZ80%5D.zip | none |  |  | select for virtual keyboard; hotkey-x to configure kempston joystick
