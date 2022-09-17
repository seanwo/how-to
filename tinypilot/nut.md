## Install Network UPS Tools

source: https://docs.technotim.live/posts/NUT-server-guide/  
source: https://networkupstools.org/docs/user-manual.chunked/ar01s06.html  

This will all your Raspberry Pi to monitor your attached UPS and act as a Network UPS Tools (NUT) server for all devices connected to the UPS.

```console
sudo apt install nut nut-client nut-server
```

Run the scanner to find your UPS

```console
sudo nut-scanner -U
```

You should see something similar to:

```
Scanning USB bus.
[nutdev1]
	driver = "usbhid-ups"
	port = "auto"
	vendorid = "051D"
	productid = "0002"
	product = "Back-UPS XS 1300 LCD FW:836.H7 .D USB FW:H7"
	serial = "000000000000"
	vendor = "American Power Conversion"
	bus = "001"
```

Make a backup of the original configuraiton files

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
maxretry = 3

[apc-server]
	driver = "usbhid-ups"
	port = "auto"
	desc = "Back-UPS XS 1300 LCD"
	vendorid = "051D"
	productid = "0002"
	serial = "000000000000"
	ignorelb
	override.battery.charge.low = 15
```
NOTE: ```ignorelb``` and ```override.battery.charge.low``` are set to override the UPS default low charge percentage.  
NOTE: ```serial``` should be your real serial number.  

Edit upsmon.conf

```console
sudo vi /etc/nut/upsmon.conf
```

```
RUN_AS_USER root
MONITOR apc-server@localhost 1 upsmon secret master
MINSUPPLIES 1
SHUTDOWNCMD "/sbin/shutdown -h +0"
NOTIFYCMD "/sbin/upssched"
POLLFREQ 5
POLLFREQALERT 5
HOSTSYNC 15
DEADTIME 15 
#POWERDOWNFLAG /etc/killpower
NOTIFYFLAG ONLINE SYSLOG+WALL+EXEC
NOTIFYFLAG ONBATT SYSLOG+WALL+EXEC
NOTIFYFLAG LOWBATT SYSLOG+WALL+EXEC
NOTIFYFLAG COMMOK SYSLOG+WALL+EXEC
NOTIFYFLAG COMMBAD SYSLOG+WALL+EXEC
NOTIFYFLAG SHUTDOWN SYSLOG+WALL+EXEC
NOTIFYFLAG REPLBATT SYSLOG+WALL+EXEC
NOTIFYFLAG NOCOMM SYSLOG+WALL+EXEC
NOTIFYFLAG FSD SYSLOG+WALL+EXEC
RBWARNTIME 43200
NOCOMMWARNTIME 300
#Configure time for all secondary systems to shutdown properly then power off the UPS load; make sure you leave enough battery percentage for this
FINALDELAY 120
```
NOTE: set ```secret``` to an actual secret you will use later on the client.

Edit upsd.conf
```console
sudo vi /etc/nut/upsd.conf
```

```
MAXAGE 15
LISTEN 0.0.0.0 3493
```

Edit nut.conf
```console
sudo vi /etc/nut/nut.conf
```

```
MODE=netserver
```

Edit upsd.users
```console
sudo vi /etc/nut/upsd.users
```

```
[admin]
password = secret
actions = set
actions = fsd
instcmds = ALL

[monmaster]
password = secret
upsmon master
 ```
NOTE: set ```secret``` to an actual secret you used in upsmon.conf.

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
          #prevents FINALDELAY from running:
          #/usr/sbin/upsmon -c fsd
          ;;
       repbatt)
          logger -t upssched-cmd "The battery needs to be replaced!"
          ;;
       nocomm)
          logger -t upssched-cmd "The battery needs to be replaced!"
          ;;
       force-shutdown)
          logger -t upssched-cmd "Forced shutdown in progress"
          #prevents FINALDELAY from running:
	  #/usr/sbin/upsmon -c fsd
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
sudo service nut-server restart
sudo service nut-client restart
sudo systemctl restart nut-monitor
sudo upsdrvctl stop
sudo upsdrvctl start
```

Check that the service is up and monitoring the UPS

```console
upsc apc-server@localhost
```

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
