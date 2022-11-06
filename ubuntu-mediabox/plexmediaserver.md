## Install Plex Media Server (Media Server)

source: https://linoxide.com/linux-how-to/install-plex-media-server-ubuntu/

```console
wget -q -O - https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo sh -c 'echo "deb https://downloads.plex.tv/repo/deb public main" >> /etc/apt/sources.list.d/plexmediaserver.list'
sudo apt update
sudo apt install plexmediaserver
sudo systemctl enable plexmediaserver
sudo systemctl start plexmediaserver
```

Goto http://localhost:32400/web/ and confirm you have a running Plex server.  Sign into your Plex account.

```console
sudo vi /etc/apt/sources.list.d/plexmediaserver.list
```
and uncomment out the the repo which was clobbered during the install:
```
# When enabling this repo please remember to add the PlexPublic.Key into the apt setup.
# wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -
deb https://downloads.plex.tv/repo/deb/ public main
```

Remove the old package list file now:
```console
sudo rm -rf /etc/apt/sources.list.d/*.dpkg-old
```

Starting with build 12.9.1 you are now required to select your GPU in the Preferences.xml file by adding the HardwareDevicePath of the GPU you want to use.  For me the Nvidia Quaddro P400 is located at /dev/dri/renderD129.

Add parameter to /var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml:
```
HardwareDevicePath="/dev/dri/renderD129"
```

Configure PLEX Libraries (/mnt/media/Movies, /mnt/media/Recorded, /mnt/media/Torrents, /mnt/media/Videos) after disk structure is complete.
