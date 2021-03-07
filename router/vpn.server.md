## VPN Server

Setting up an OpenVPN Server on your router for external access is pretty push button.

source: https://www.snbforums.com/threads/how-to-setup-a-vpn-server-with-asus-routers-380-68-updated-08-24.33638/

### Initialize the OpenVPN Server

Simply turn it on with the following settings:

**VPN -> VPN Server -> Basic Config**

```
Server instance: Server 1
Enable OpenVPN Server: ON
VPN Details: General
Client will use VPN to access: Both
```

**VPN -> VPN Server -> Username and Password**

```
Connection Status: Disconnected
Username: [your admin username]
Password: [your admin password]
```

**VPN -> VPN Server -> Basic Config**

```
Server instance: Server 1
Enable OpenVPN Server: ON
VPN Details: Advanced Settings
```

**VPN -> VPN Server -> Advanced Settings**

```
Interface Type: TUN
Protocol: UDP
Server Port: 1194
Authorization Mode: TLS
Username/Password Authentication: Yes
Username/Password Auth. Only: No
TLS control channel security: Disable
HMAC Authentication: Default
VPN Subnet/Netmask: 10.8.0.0 255.255.255.0
Advertise DNS to clients: No
Data ciphers: AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC
Compression: Disable
Log verbosity: 3
Manage Client-Specific Options: No
```

I suggest you backup the private/public keys, certificates, and parameters for the server that get created in case you need to rebuild it.

They are located on /jffs/openvpn after the server is initialized:

```console
admin@RT-AX3000-B188:/jffs/openvpn# ls -la vpn_crt_server*
-rw-------    1 admin    root          1647 Nov  8 13:47 vpn_crt_server1_ca
-rw-------    1 admin    root          1704 Nov  8 13:47 vpn_crt_server1_ca_key
-rw-------    1 admin    root          1749 Nov  8 13:47 vpn_crt_server1_client_crt
-rw-------    1 admin    root          1708 Nov  8 13:47 vpn_crt_server1_client_key
-rw-------    1 admin    root          1785 Nov  8 13:47 vpn_crt_server1_crt
-rw-------    1 admin    root           424 Nov  8 13:46 vpn_crt_server1_dh
-rw-------    1 admin    root          1704 Nov  8 13:47 vpn_crt_server1_key
```

### Setup an OpenVPN client to access your router

**VPN -> VPN Server -> Basic Config**

Export the .ovpn file for import into your client applications.
```
Export OpenVPN configuration file: Export
```

Mac:
```console
brew install tunnelblick
```

Android:

https://play.google.com/store/apps/details?id=net.openvpn.openvpn
