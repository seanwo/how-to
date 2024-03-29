## Setup Network UPS Tool
 
source: https://networkupstools.org/docs/user-manual.chunked/ar01s06.html  

I have a Network UPS Tool (NUT) Server running on a [Raspberry Pi Management Server](/tinypilot/tinypilot.md) that monitors the UPS that this NAS is plugged into.  I want to setup a NUT client on this NAS to be informed when to shutdown during the low power warning.  

Make a backup of the original configuration files

```console
cd /etc/nut
sudo cp nut.conf nut.example.conf
sudo cp upsd.conf upsd.example.conf
sudo cp upsd.users upsd.example.users
sudo cp ups.conf ups.example.conf
sudo cp upsmon.conf uspmon.example.conf
```

Edit ups.conf

```console
sudo vi /etc/nut/ups.conf
```

```
[apc-server]
driver = usbhid-ups
port = auto
```

Edit upsmon.conf

```console
sudo vi /etc/nut/upsmon.conf
```

```
RUN_AS_USER root
MONITOR apc-server@192.168.###.### 1 upsmon secret slave
MINSUPPLIES 1
SHUTDOWNCMD "/sbin/shutdown -h +0"
NOTIFYCMD /sbin/upssched
POLLFREQ 5
POLLFREQALERT 5
HOSTSYNC 15
DEADTIME 15
#POWERDOWNFLAG /etc/killpower
NOTIFYMSG ONLINE    "UPS %s on line power"
NOTIFYMSG ONBATT    "UPS %s on battery"
NOTIFYMSG LOWBATT   "UPS %s battery is low"
NOTIFYMSG FSD       "UPS %s: forced shutdown in progress"
NOTIFYMSG COMMOK    "Communications with UPS %s established"
NOTIFYMSG COMMBAD   "Communications with UPS %s lost"
NOTIFYMSG SHUTDOWN  "Auto logout and shutdown proceeding"
NOTIFYMSG REPLBATT  "UPS %s battery needs to be replaced"
NOTIFYMSG NOCOMM    "UPS %s is unavailable"
NOTIFYMSG NOPARENT  "upsmon parent process died - shutdown impossible"
NOTIFYFLAG ONLINE   SYSLOG+WALL+EXEC
NOTIFYFLAG ONBATT   SYSLOG+WALL+EXEC
NOTIFYFLAG LOWBATT  SYSLOG+WALL+EXEC
NOTIFYFLAG FSD      SYSLOG+WALL+EXEC
NOTIFYFLAG COMMOK   SYSLOG+WALL+EXEC
NOTIFYFLAG COMMBAD  SYSLOG+WALL+EXEC
NOTIFYFLAG SHUTDOWN SYSLOG+WALL+EXEC
NOTIFYFLAG REPLBATT SYSLOG+WALL+EXEC
NOTIFYFLAG NOCOMM   SYSLOG+WALL+EXEC
NOTIFYFLAG NOPARENT SYSLOG+WALL+EXEC
RBWARNTIME 43200
NOCOMMWARNTIME 300
FINALDELAY 5
```
NOTE: set ```secret``` to the actual secret used with the net-server on the ```MONITOR``` line.
NOTE: set the ip address to the net-server on the ```MONITOR``` line.

Edit upsd.conf
```console
sudo vi /etc/nut/upsd.conf
```

```
MAXAGE 15
LISTEN 127.0.0.1 3493
```

Edit nut.conf
```console
sudo vi /etc/nut/nut.conf
```

```
MODE=netclient
```

Edit upsd.users
```console
sudo vi /etc/nut/upsd.users
```

```
[admin]
[admin]
password = secret
actions = set
actions = fsd
instcmds = ALL

[monmaster]
password = secret
upsmon master
 ```
NOTE: set ```secret``` to an actual secret.

Edit upssched.conf
```console
sudo vi /etc/nut/upssched.conf
```

```
CMDSCRIPT /etc/nut/upssched-cmd
PIPEFN /etc/nut/upssched.pipe
LOCKFN /etc/nut/upssched.lock

AT ONLINE * EXECUTE online
AT ONBATT * EXECUTE onbatt
AT LOWBATT * EXECUTE lowbatt
AT COMMOK * EXECUTE commok
AT COMMBAD * EXECUTE commbad
AT SHUTDOWN * EXECUTE powerdown
AT REPLBATT * EXECUTE replbatt
AT NOCOMM * EXECUTE nocomm
AT FSD * EXECUTE force-shutdown
AT NOPARENT * EXECUTE noparent
```

Edit upssched-cmd
```console
sudo vi /etc/nut/upssched-cmd
```

```
#!/bin/sh
 case $1 in
       online)
          logger -t upssched-cmd "Running on line power"
          ;;
       onbatt)
          logger -t upssched-cmd "Line Power Fail, system running on battery power"
          ;;
       lowbatt)
          logger -t upssched-cmd "Low battery power"
          ;;
       commok)
          logger -t upssched-cmd "Communications with the UPS are established"
          ;;
       commbad)
          logger -t upssched-cmd "Communications with the UPS are lost"
          ;;
       powerdown)
          logger -t upssched-cmd "Automatic logout and shutdown proceeding"
          /usr/sbin/upsmon -c fsd
          ;;
       repbatt)
          logger -t upssched-cmd "The battery needs to be replaced!"
          ;;
       nocomm)
          logger -t upssched-cmd "The battery needs to be replaced!"
          ;;
       force-shutdown)
          logger -t upssched-cmd "Forced shutdown in progress"
	  /usr/sbin/upsmon -c fsd
          ;;
       noparent)
          logger -t upssched-cmd "upsmon parent process died - shutdown impossible"
          ;;
       *)
          logger -t upssched-cmd "Unrecognized command: $1"
          ;;
esac

```

Make upssched-cmd executable
```console
sudo chmod +x /etc/nut/upssched-cmd
```
Restart all the nut based services

```console
sudo service nut-client restart
sudo systemctl restart nut-monitor
```

Check that the service is up and monitoring the UPS

```console
upsc apc-server@192.168.###.###
```
NOTE: use the ip address to the net-server.

You should see something similar to:

```
Init SSL without certificate database
battery.charge: 100
battery.charge.low: 25
battery.charge.warning: 50
battery.date: 2030/00/38
battery.mfr.date: 2008/01/16
battery.runtime: 8724
battery.runtime.low: 120
battery.type: PbAc
battery.voltage: 27.1
battery.voltage.nominal: 24.0
device.mfr: American Power Conversion
device.model: Back-UPS XS 1300 LCD
device.serial: 8B0803R29816  
device.type: ups
driver.flag.ignorelb: enabled
driver.name: usbhid-ups
driver.parameter.pollfreq: 30
driver.parameter.pollinterval: 1
driver.parameter.port: auto
driver.parameter.productid: 0002
driver.parameter.serial: 000000000000
driver.parameter.synchronous: no
driver.parameter.vendorid: 051D
driver.version: 2.7.4
driver.version.data: APC HID 0.96
driver.version.internal: 0.41
input.sensitivity: medium
input.transfer.high: 139
input.transfer.low: 88
input.transfer.reason: input voltage out of range
input.voltage: 125.0
input.voltage.nominal: 120
ups.beeper.status: disabled
ups.delay.shutdown: 20
ups.firmware: 836.H7 .D
ups.firmware.aux: H7 
ups.load: 2
ups.mfr: American Power Conversion
ups.mfr.date: 2008/01/16
ups.model: Back-UPS XS 1300 LCD
ups.productid: 0002
ups.realpower.nominal: 780
ups.serial: 000000000000  
ups.status: OL
ups.test.result: No test initiated
ups.timer.reboot: 0
ups.timer.shutdown: -1
ups.vendorid: 051d
```
