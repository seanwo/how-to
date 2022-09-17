# Raspberry Pi NAS (PiNAS)

![alt text](cover.on.small.gif "pinas")

## Parts Needed

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
* You will need to re-pin the Pico PSU side of the the replacement SATA power cable if you use it (instead of the one that came with the Pico PSU)  If you do not re-pin it, YOU WILL DESTROY ANY HARD DRIVE YOU PLUG INTO IT.

## Setup
* [Install the Base OS](baseos.md)
* [Install HD-IDLE](hdidle.md)
* [Manually Formatting Hard Drives (Optional)](drives.md)
* [Install OpenMediaVault (OMV)](omv.md)
* [Setup Network UPS Tool (NUT) Client](nutmd)
* [Install Utilities (Optional)](utilities.md)
* [Setup Apple Time Machine Support](timemachine.md)
