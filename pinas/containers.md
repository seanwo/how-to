## Setup Container Support

source: https://nerdiy.de/en/howto-raspberry-pi-docker-container-mit-openmediavault-omv-und-portainer-nutzen/

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
