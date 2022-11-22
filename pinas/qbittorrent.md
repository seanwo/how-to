## Setup qBittorrent

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
