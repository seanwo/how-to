## Install qBittorrent (Content Acquisition Tool)

source: https://www.linuxbabe.com/ubuntu/install-qbittorrent-ubuntu-18-04-desktop-server

```console
sudo sh -c 'echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu focal main" >> /etc/apt/sources.list.d/qbittorrent-team-ubuntu-qbittorrent-stable-focal.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D35164147CA69FC4
sudo apt update
sudo apt install qbittorrent
```

Set qbittorrent to autostart with system:
```console
sudo apt update
sudo apt install gnome-startup-applications
gnome-session-properties
```

Name: qBittorrent  
Command: /usr/bin/qbittorrent

Configure the client with your proxy settings such as one provided by https://www.privateinternetaccess.com.

[Sample QBitTorrent Configuration](qbittorent.preferences.md)

After configuring the you proxy, check your torrent ip using https://torguard.net/checkmytorrentipaddress.php and make sure it is showing the ip address of the proxy torrent; not the one returned by https://www.whatsmyip.org.

Apply an IP filter list:
```console
cd ~/Downloads
wget http://upd.emule-security.org/ipfilter.zip
unzip ipfilter.zip
mv guarding.p2p ../guarding.dat
```
Add /home/mediauser/guarding.dat to the ip filter list in qbittorent under connections.

Some proxies change their IP addresses which cause long live connections to stall.  Setup a cron job to restart it every 2 hours:
```console
vi ~/restartqbittorrent.sh
```
Use the following file and update as appropriate for your accounts and directories:

[restartqbittorrent.sh](restartqbittorrent.sh)
```console
chmod +x ~/restartqbittorrent.sh
```

```console
crontab -e
```
```
5 */2 * * * /home/mediauser/restartqbittorrent.sh >/dev/null 2>&1
```
