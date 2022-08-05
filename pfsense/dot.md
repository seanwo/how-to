## Setup DNS over TLS

source: [https://docs.netgate.com/pfsense/en/latest/recipes/dns-over-tls.html](https://docs.netgate.com/pfsense/en/latest/recipes/dns-over-tls.html).  

**System>General Setup>DNS Server Settings**
* DNS Servers: Address: ``1.1.1.1`` Hostname: ``cloudflare-dns.com``
* DNS Servers: Address: ``1.0.0.1`` Hostname: ``cloudflare-dns.com``
* DNS Resolution Behavior: ``Use local DNS (127.0.0.1), ignore remote DNS Servers``
* DNS Server Override: Allow DNS server list to be overridden by DHCP/PPP on WAN or remote OpenVPN Server: :x:

**Services>DNS Resolver>General Settings>General DNS Resolver Options**
* DNSSEC: Enable DNSSEC Support: :x:
* DNS Query Forwarding: Enable Forwarding Mode: :white_check_mark:
* DNS Query Forwarding: Use SSL/TLS for outgoing DNS Queries to Forwarding Servers: :white_check_mark:
* DHCP Registration: Register DHCP leases in DNS Resolver: :white_check_mark:
* Static DHCP: Register DHCP static mappings in the DNS Resolver: :white_check_mark:
