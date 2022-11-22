## Setup Containers

source: https://nerdiy.de/en/howto-raspberry-pi-docker-container-mit-openmediavault-omv-und-portainer-nutzen/
source: https://github.com/dperson/openvpn-client/  
source: https://github.com/linuxserver/docker-qbittorrent  
source: https://github.com/dperson/openvpn-client/issues/238  
source: https://docs.docker.com/compose/compose-file/compose-file-v3/  
source: https://github.com/willfarrell/docker-autoheal  

OMV6 GUI:

System>omv-extras>Docker>Install  

System>omv-extras>Portainer>Install

System>omv-extras>Portainer>Open web  

Set a password for the admin account.

CLI:

From the console, create a top level directory to store our container appdata.

```console
sudo mkdir /srv/appdata
```

_I recommend creating the appdata on a seperate flash drive to extend the life of the CM4 eMMC_

```console
sudo mkdir /srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/appdata/
sudo ln -s /srv/appdata /srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/appdata/
```

_where the target is a permanently mounted ext4 formatted flashdrive_

This procedure will install a qBittorrent container and tunnel it through an OpenVPN client container.  
These containers will be monitored and restarted using an autoheal container.  
The example uses a PrivateInternetAccess (PIA) server in Switzerland.  

Create appdata directories for the vpn and qBittorrent containers:
```console
sudo mkdir /srv/appdata/openvpn
sudo mkdir /srv/appdata/qbittorrent/config
```

Put your ca cert and ovpn files in the vpn appdata directory:
```console
cd /srv/appdata/vpn
sudo wget https://www.privateinternetaccess.com/openvpn/openvpn.zip
sudo apt install unzip
sudo unzip ./openvpn.zip
sudo rm ./openvpn.zip
```

Customize this .yaml file: [openvpn-qbittorrent.yaml](openvpn-qbittorrent.yaml)

```
services:
  openvpn:
    environment:
      VPN_AUTH: 'pia_username;pia_password'
```
Change VPN_AUTH to be your vpn (in my case PIA) username and password.  

Portainer GUI:

* Create a stack named openvpn-qbittorrent using the customized [openvpn-qbittorrent.yaml](openvpn-qbittorrent.yaml) above by uploading it and pressing "Deploy the stack".  
* Create a stack named autoheal using the [autoheal.yaml](autoheal.yaml) by uploading it and pressing "Deploy the stack".  

Check the openvpn container log to ensure the openvpn client is online.
