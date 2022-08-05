# pfSense Router Configuration

_"pfSense® software is a free, open source customized distribution of FreeBSD specifically tailored for use as a firewall and router that is entirely managed via web interface. In addition to being a powerful, flexible firewalling and routing platform, it includes a long list of related features and a package system allowing further expandability without adding bloat and potential security vulnerabilities to the base distribution."_

source: [https://www.pfsense.org/about-pfsense/](https://www.pfsense.org/about-pfsense/) 

To get started with pfSense go to [https://www.pfsense.org/getting-started/](https://www.pfsense.org/getting-started/)

![alt text](router.jpg "router")

Parts List:  
* [KingNovy Intel Celeron N5105 4x 2.5GbE](https://www.aliexpress.com/item/3256803806996430.html) ~$200
* [Crucial RAM 16GB Kit (2x8GB) DDR4 3200MHz CL22 (running @ 2933MHz) SODIMM](https://www.amazon.com/dp/B08C4WV6FT) $60
* [Intel SSDSA2CW120G3 320 Series 120GB SATA 3Gb/s 2.5" SSD](https://www.ebay.com/sch/i.html?_nkw=SSDSA2CW120G3) $20-$40 (I had one lying around)
* [FPV HDMI Cable, Kework 20cm FPV HDMI Slim Flat Cable, 90 Degree Downward Standard HDMI Male Interface to Standard HDMI Male Interface](https://www.amazon.com/dp/B07FHXF3LS) $16
* [VCE HDMI Coupler HDMI Female to Female Connector 4K HDMI to HDMI Adapter (2-Pack)](https://www.amazon.com/dp/B00V7SFR8Y) $6
* [Noctua NF-P12 redux-1700 PWM, High Performance Cooling Fan, 4-Pin, 1700 RPM (120mm, Grey)](https://www.amazon.com/dp/B07CG2PGY6) $15
* [Noctua NA-FC1, 4-Pin PWM Fan Controller (Black)](https://www.amazon.com/dp/B072M2HKSN) $25
* [Noctua NA-SAVP1 chromax.Grey, Anti-Vibration Pads for 120/140mm Noctua Fans (16-Pack, Grey)](https://www.amazon.com/dp/B07SWRXT3D) $9
* [Noctua NA-SAV4, Silicone Anti-Vibration Fan Mount Set (16-Pack, Brown)](https://www.amazon.com/dp/B071W6KYCG) $9
* [120mm Black Finger Grills (4 Pack)](https://www.amazon.com/dp/B01H0P7OC4) $8
* [Facmogu DC 12V 3A Power Adapter, 36 Watt AC 100-240V to DC 12V Transformers, Switching Power Supply for LCD Monitor, Wireless Router, CCTV Cameras 2.1mm X 5.5mm US Plug](https://www.amazon.com/dp/B073WSWT34) $12 (optional to replace cheap original)

**Configuration**:

* [Installing pfSense](install.md)
* Create a LAN Bridge
* [Setup a IPV4 DHCP Server](dhcpserver.md)
* [Configure Static DHCP Reservations](dhcpstatic.md)
* [Setup DNS over TLS](dot.md)
* [Enable UPnP](upnp.md)
* [Setup SSH Access](ssh.md)
* [Configure SSH User Keys](sshkeys.md)
* [Setup Dynamic DNS](ddns.md)
* [Configure Email Notifications](email.md)
* [Setup Port Forwarding](portforwarding.md)
* Setup OpenVPN Server
