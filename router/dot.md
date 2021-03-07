## DNS over TLS

### Why use DNS over TLS instead of your ISPs standard DNS?

"_DNS is the phonebook of the Internet; DNS resolvers translate human-readable domain names into machine-readable IP addresses. By default, DNS queries and responses are sent in plaintext (via UDP), which means they can be read by networks, ISPs, or anybody able to monitor transmissions. Even if a website uses HTTPS, the DNS query required to navigate to that website is exposed._
  
_This lack of privacy has a huge impact on security and, in some cases, human rights; if DNS queries are not private, then it becomes easier for governments to censor the Internet and for attackers to stalk users' online behavior._"

source: https://www.cloudflare.com/learning/dns/dns-over-tls/


### How to configure DNS over TLS in Asuswrt-Merlin?

https://github.com/RMerl/asuswrt-merlin.ng/wiki/DNS-Privacy

**WAN -> Internet Connection -> WAN DNS Setting**

```
DNS Privacy Protocol: DNS-over-TLS (DoT)
DNS-over-TLS Profile: Strict
```

**WAN -> Internet Connection -> DNS-over-TLS Server List**

```
Address: 1.1.1.1
TLS Port: 853
TLS Hostname: cloudflare-dns.com
```
```
Address: 1.0.0.1
TLS Port: 853
TLS Hostname: cloudflare-dns.com
```

Please review cloudflare.com's privacy policy:

https://www.cloudflare.com/privacypolicy/
