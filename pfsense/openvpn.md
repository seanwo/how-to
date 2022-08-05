## Setup an OpenVPN Server

source: [https://docs.netgate.com/pfsense/en/latest/recipes/openvpn-ra.html](https://docs.netgate.com/pfsense/en/latest/recipes/openvpn-ra.html).  
source: [https://www.comparitech.com/blog/vpn-privacy/openvpn-server-pfsense/](https://www.comparitech.com/blog/vpn-privacy/openvpn-server-pfsense/).  

### System>Certificate Manager>CAs
* Descriptive Name: ``OpenVPN Internal CA``
* Method: ``Create an internal Certificate Authority``
* Key type: ``RSA``
* Key length: ``4096``
* Digest Algorithm: ``sha512``
* Lifetime (days): ``3650``
* Common Name: ``openvpn-internal-ca``

### System>Certificate Manager>Certificates
* Descriptive Name: ``OpenVPN Server Certificate``
* Method: ``Create an internal Certificate``
* Certificate Authority: ``OpenVPN Internal CA``
* Key type: ``RSA``
* Key length: ``4096``
* Digest Algorithm: ``sha512``
* Lifetime: ``365``
* Certificate type: ``Server Certificate``
* Common Name: ``openvpn-server-cert``

### System>User Manager
* Username: ``vpnuser``
* Password: ``[secure password]``

### System>Certificate Manager>Certificates
* Descriptive Name: ``OpenVPN User Certificate``
* Method: ``Create an internal Certificate``
* Certificate Authority: ``OpenVPN Internal CA``
* Key type: ``RSA``
* Key length: ``4096``
* Digest Algorithm: ``sha512``
* Lifetime: ``365``
* Certificate type: ``User Certificate``
* Common Name: ``openvpn-user-cert``

### VPN>OpenVPN>Servers>General Information
* Server mode: ``Remote Access (SSL/TLS + User Auth)``
* Local port: ``1194``
* Descriptions: ``OpenVPN Server``

### VPN>OpenVPN>Servers>Cryptographic Settings
* TLS Configuration: Use a TLS Key: :white_check_mark:
* TLS Configuration: Automatically generate a TLS Key: :white_check_mark:
* Peer Certificate Authority: ``OpenVPN Internal CA``
* Server Certificate: ``OpenVPN Server Certificate``
* DH Parameter Length: ``4096``
* Auth digest algorithm: ``SHA512``

### VPN>OpenVPN>Servers>Tunnel Settings
* IPv4 Tunnel Network: ``192.168.YYY.0/24`` *(different than 192.168.XXX.0/24)*
* Redirect IPv4 Gateway: ``Force all client-generated IPv4 traffic through the tunnel``

### VPN>OpenVPN>Servers>Advanced Client Settings
* DNS Default Domain enable: Provide a DNS server list to clients. :white_check_mark:
* DNS Server 1: ``192.168.xx.1``

### VPN>OpenVPN>Servers>Advanced Configuration
* UDP Fast I/O: Use fast I/O operations with UDP writes to tun/tap: :white_check_mark:
* Gateway creation: ``IPv4 only``

### Status>System Logs>OpenVPN
```console
Initialization Sequence Complete
```

### Firewall>Rules>OpenVPN
* Address Family: ``IPv4``
* Protocol: ``Any``
* Source: Network ``192.168.XXX.0`` / ``24``
* Description: ``Allow OpenVPN``

### Firewall>Rules>WAN
* Address Family: ``IPv4``
* Source: ``Any``
* Protocol: ``UDP``
* Destination Port Range: ``1194``
* Description: ``Allow OpenVPN``

### Server>DNS Resolver>Access Lists
* Access List name: ``OpenVPN``
* Action: ``Allow``
* Networks: ``192.168.YYY.0``/``24`` Description: ``OpenVPN``

### System>Package Manager>Available Packages
Install openvpn-client-export  

### VPN>OpenVPN>Client Export
* Hostname Resolution: ``Other``
* Hostname: ``[DDNS Hostname]``
* Select Most Clients

![alt text](ca.jpg "ca")

![alt text](certs.jpg "certs")

![alt text](vpnuser.jpg "vpnuser")

![alt text](openvpn.jpg "openvpn")

![alt text](openvpnbr0rule.jpg "openvpnbr0rule")

![alt text](openvpnwanrule.jpg "openvpnwanrule")

![alt text](dnsresolveraccesslist.jpg "dnsresolveraccesslist")

![alt text](vpnexportpkg.jpg "vpnexportpkg")

![alt text](vpnexport.jpg "vpnexport")
