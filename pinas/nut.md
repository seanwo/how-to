## Setup a Network UPS Tool (NUT) Client

source: https://forum.openmediavault.org/index.php?thread/41186-how-to-use-the-openmediavault-nut-plugin/  
source: https://networkupstools.org/docs/user-manual.chunked/ar01s06.html
source: https://docs.openmediavault.org/en/6.x/various/advset.html

I have a Network UPS Tool (NUT) Server running on a [Raspberry Pi Management Server](/tinypilot/tinypilot.md) that monitors the UPS that this NAS is plugged into.  I want to setup a NUT client on this NAS to be informed when to shutdown during the low power warning.

In the OMV6 GUI:  

#### System>Plugins>Search>```openmediavault-nut```>Install  

#### Services->UPS:

* Enabled: true
* Identifier: apc-server
* Comment:
* Netclient hostname: 192.168.###.###
* Netclient user name: admin
* Netclient password: secret
* Powervalue: 1
* Shutdown mode: UPS reaches low battery

NOTE: set ```Identifier``` to the name/identifier of the NUT server.  
NOTE: set ```Netclient hostname``` to the actual ip address of the NUT server.  
NOTE: set ```Netclient password``` to the actual secret you used on the NUT server.  

I don't want the NAS to control shutting down the UPS itself so we have to alter a configuration file vi an OVM environment variable:
```console
sudo omv-env set -- OMV_UPSMON_POWERDOWNFLAG "/dev/null"
sudo omv-salt stage run prepare
sudo omv-salt stage run deploy
```
