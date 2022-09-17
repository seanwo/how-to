## Install OpenMediaVault OMV

source: https://pimylifeup.com/raspberry-pi-openmediavault/  
source: https://docs.openmediavault.org/en/6.x/various/advset.html  

You will need wget to get and then run the OMV installer script:
```console
sudo apt install wget
```
Run the OMV installation script.  
```console
wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install | sudo bash
sudo sync; sudo reboot
```
Note: This did not completely install for me the first time. It looked like it completed but the web interface was not available after the reboot. So I repeated the step above and it worked the second time around.  Possible dependency problem.  
  
Make sure everything is up-to-date again:
```console
sudo apt update
sudo apt full-upgrade
sudo sync; sudo reboot
```

In order for network discovery (avahi-daemon) to work properly (with the interceptor board) you need to make it aware of the "wan" VLAN.
```console
sudo omv-env set -- OMV_AVAHIDAEMON_ALLOW_INTERFACES "wan"
sudo omv-salt stage run prepare
sudo omv-salt stage run deploy
```

Hopefully, you can now access OMV on http://pinas.  
