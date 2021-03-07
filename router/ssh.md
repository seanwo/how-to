## Configure RSA Keys for SSH

### Why use RSA Keys instead of Passwords?

_"SSH Keys are a way to further secure your server against malicious activities directed at trying to SSH into your server. SSH Keys provide a level of authorization that can only be fulfilled by those who have ownership to the private key associated with the public key on the server. An unwanted visitor may be able to get access to the server’s public key, but without the associated private key they will be unable to gain access to the server, even if they know the password."_

source: https://www.hostwinds.com/guide/ssh-password-vs-key-based-authentication/

### How to generate a RSA public/private key pair

Mac or Linux: https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/create-with-openssh/  
Windows: https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/create-with-putty/

### Setting up SSH on Asuswrt-Merlin

https://github.com/RMerl/asuswrt-merlin.ng/wiki/SSHD

**Administration -> System -> Service**

```
Enable SSH: LAN only
Allow SSH Port Forwarding: No
SSH Port: 22
Allow Password Login: No
Enable SSH Brute Force Protection: Yes
Authorized Keys: [your ssh-rsa public key]
Idle Timeout: 20 minute(s)
```

Do not enable SSH access via WAN.  See VPN Server configuration.

Connecting to your router via SSH using your RSA key on your LAN (mac example)

```console
ssh -i ./ssh/id_rsa_router admin@192.168.0.1
```
