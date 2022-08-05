## Installing pfSense

source: [https://docs.netgate.com/pfsense/en/latest/install/index.html](https://docs.netgate.com/pfsense/en/latest/install/index.html). 
source: [https://www.pfsense.org/download/](https://www.pfsense.org/download/). 

Install pfSense on the device via usb memory stick.  
Configure WAN (on igc0) and LAN1 (on igc1) and get connected to the web UI on 192.168.1.1. 

**Wizard>pfSense Setup**
```
Hostname: pfSense
Domain: home.arpa
Primary DNS: 1.1.1.1
Secondary DNS: 1.0.0.1
Override DNS: Uncheck
Time server hostname: default
Time zone: America/Chicago
WAN Interface: DHCP
Block RFC1918 Private Networks: Block private networks from entering via WAN: Checked [Unless internal testing]
Block bogon networks: Block non-internet routed networks from entering via WAN: Checked [Unless internal testing]
LAN IP Address: 192.168.XXX.1
Subnet Mask: 24
Admin Password: [secure password; not default]
```
**System>Advanced>Miscellaneous>Cryptographic & Thermal Hardware**
```
Thermal Sensors: Intel Core* CPU on-die thermal sensor
```
