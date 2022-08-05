## Setup Dynamic DNS

source: [https://docs.netgate.com/pfsense/en/latest/services/dyndns/client.html](https://docs.netgate.com/pfsense/en/latest/services/dyndns/client.html).  
source: [https://community.spiceworks.com/how_to/126203-dynamicdns-freedns-on-pfsense](https://community.spiceworks.com/how_to/126203-dynamicdns-freedns-on-pfsense).  

**Services>Dynamic DNS>Dynamic DNS Client**
* Service Type: ``freeDNS``
* Interface to monitor: ``WAN``
* Hostname: ``[your full freeDNS subdomain]``
* Username: ``[]`` *leave blank*
* Password: ``[Authentication Token]`` *freeDNS Direct URL - Token is after the .php?*
