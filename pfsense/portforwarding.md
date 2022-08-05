## Setup Port Forwarding

source: [https://docs.netgate.com/pfsense/en/latest/nat/port-forwards.html](https://docs.netgate.com/pfsense/en/latest/nat/port-forwards.html).  

**Firewall>NAT>Port Forward**
* Interface: ``WAN``
* Address Family: ``IPv4``
* Protocol: ``TCP``
* Destination port range: From port: ``Other`` Custom: ``[port]`` To port: ``Other`` Custom: ``[port]`` *(incoming port)*
* Redirect target IP: Type: Single host Address: ``[192.168.XXX.##]`` *(target host)*
* Redirect target port: Port: ``[port]`` *(target port)*
* Description: ``[description]``

Repeat for each forwarding rule.
