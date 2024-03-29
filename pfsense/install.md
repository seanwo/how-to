## Installing pfSense

source: [https://docs.netgate.com/pfsense/en/latest/install/index.html](https://docs.netgate.com/pfsense/en/latest/install/index.html).  
source: [https://www.pfsense.org/download/](https://www.pfsense.org/download/).  

Install pfSense on the device via usb memory stick.  
Configure WAN (on igc0) and LAN1 (on igc1).  
Connected to the web UI on [http:///192.168.1.1](http://192.168.1.1)  

### Wizard>pfSense Setup
* Hostname: ``pfSense``
* Domain: ~~``home.arpa``~~ ``local.lan``
* Primary DNS: ``1.1.1.1``
* Secondary DNS: ``1.0.0.1``
* Override DNS: :x:
* Time server hostname: ``[default]``
* Time zone: ``America/Chicago``
* WAN Interface: ``DHCP``
* Block RFC1918 Private Networks: Block private networks from entering via WAN: :white_check_mark:
* Block bogon networks: Block non-internet routed networks from entering via WAN: :white_check_mark:
* LAN IP Address: ``192.168.TTT.1`` *(where* ``TTT`` *is temporary until you establish your primary subnet on bridge* ``BR0`` *that contains* ``LAN1 LAN2 LAN3`` *)*
* Subnet Mask: ``24``
* Admin Password: ``[choose a secure password]``

### System>Advanced>Miscellaneous>Cryptographic & Thermal Hardware

* Thermal Sensors: ``Intel Core* CPU on-die thermal sensor``

### WebUI

![alt text](general.jpg "general")

![alt text](wan.jpg "wan")

![alt text](thermal.jpg "thermal")
