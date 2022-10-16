## Setup qBittorrent through a VPN

source: https://github.com/dperson/openvpn-client/  
source: https://github.com/linuxserver/docker-qbittorrent  
source: https://github.com/dperson/openvpn-client/issues/238  

This procedure will install a qBittorrent container and tunnel it through an OpenVPN client container.  
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

```
services:
  qbittorrent:
    volumes:
      - /srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/torrents:/downloads
      - /srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/movies:/movies
      - /srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/shows:/shows
```
Change the volume uuids to be the disk uuid that contains your torrent, movies, and shows shared folders.  

Go to portainer at http://pinas:9000 and create a stack named openvpn-qbittorrent using the customized .yaml by uploading it and pressing "Deploy the stack".  
Go to portainer at http://pinas:9000 and create a stack named autoheal using the [autoheal.yaml](autoheal.yaml) by uploading it and pressing "Deploy the stack".  

Check the openvpn container log to ensure the openvpn client is online.

Login to qBittorrent at http://pinas:8080 (default credentials: admin:adminadmin).  

Change the following qBittorrent settings (Tools>Options):
* Downloads>Saving Management>Default Save Path: ```/downloads/```
* Downloads>Saving Management>Keep incomplete torrents in: ```/downloads/incomplete```
* BitTorrent>Encryption mode: ```Require encryption```
* BitTorrent>Enable anonymous mode: :white_check_mark:
* BitTorrent>Torrent Queueing>Maximum active downloads: 5
* BitTorrent>Torrent Queueing>Maximum active uploads: 5
* BitTorrent>Torrent Queueing>Maximum active torrents: 10
* BitTorrent>Seeding Limits>When seeding time reaches ```1``` minutes then ```Remove torrent```
* RSS>RSS Reader>Enable fetching RSS feeds: :white_check_mark:
* RSS>RSS Reader>Feeds refresh interval: 15 min
* RSS>RSS Torrent Auto Downloader>Enable auto dowbnloading of RSS torrents: :white_check_mark:
* Web UI>Authentication>Password: ```[secure password]```

Go to http://checkmyip.torrentprivacy.com/ download the test torrent file, add it to qBittorrent and then check your published IP address.  
Go to https://whatismyipaddress.com/ip-lookup and locate the geographical region of the IP address.  It should be in Switzerland.
