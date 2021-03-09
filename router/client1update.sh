#!/bin/sh

#Domains to route through VPN
client1_domains="api.locastnet.org"

#Persistent VPN IP rules
#e.g. client1_clientlist="<rule.name>0.0.0.0>127.0.0.1>VPN" 
client1_clientlist="<router>192.168.0.1>>WAN"

#DNS server for lookup
dns_server=1.1.1.1

for domain in $client1_domains
do
    ip=`nslookup $domain $dns_server|tail +4|grep 'Address'|awk -F ":" '{print $2}'|awk '{print $1;}'|sort`
    count=1
    for i in $ip
    do
        if expr "$i" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
            client1_clientlist=$client1_clientlist'<'${domain:0:12}$count'>192.168.0.0/24>'$i'>VPN'
            let "count++"
        fi
    done
done

nvram_client1_clientlist=`nvram get vpn_client1_clientlist`

if [ $nvram_client1_clientlist != $client1_clientlist ]; then
    nvram unset vpn_client_clientlist
    nvram unset vpn_client1_clientlist
    nvram set vpn_client1_clientlist=$client1_clientlist
    nvram commit
    service restart_vpnclient1
fi
