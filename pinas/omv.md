## Install OpenMediaVault

source: https://pimylifeup.com/raspberry-pi-openmediavault/  
source: https://docs.openmediavault.org/en/6.x/various/advset.html  
source: https://www.axzez.com/forum/interceptor-carrier-board/getting-avahi-to-work-on-omv6-w-interceptor-on-wan-vlan-service-discovery  
source: https://forum.openmediavault.org/index.php?thread/37920-cron-job-checkarray-checkarray-e-md-subsystem-not-loaded-or-proc-unavailable/&postID=310582#post310582  

CLI:

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
  
If it complains about usrmerge then run the following commands and then try the above installer again:
```console
sudo apt install usrmerge
sudo sync; sudo reboot
```

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

If you do not plan on using a software RAID, you need to disable a cronjob.
```console
sudo vi /etc/cron.d/mdadm
```
```
#
# cron.d/mdadm -- schedules periodic redundancy checks of MD devices
#
# Copyright © martin f. krafft <madduck@madduck.net>
# distributed under the terms of the Artistic Licence 2.0
#

# By default, run at 00:57 on every Sunday, but do nothing unless the day of
# the month is less than or equal to 7. Thus, only run on the first Sunday of
# each month. crontab(5) sucks, unfortunately, in this regard; therefore this
# hack (see #380425).
# 57 0 * * 0 root if [ -x /usr/share/mdadm/checkarray ] && [ $(date +\%d) -le 7 ]; then /usr/share/mdadm/checkarray --cron --all --idle --quiet; fi
```

Hopefully, you can now access OMV on http://pinas.  
