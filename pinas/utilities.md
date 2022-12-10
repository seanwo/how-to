## Install Utilities

CLI:

Install IOTop in case you want to monitor the device IO performance:
```console
sudo apt install iotop
```

Install IPerf3 in case you want to run a network performance test:
```console
sudo apt install iperf3
```

Create shell script to get the CPU temperature:
```console
vi ~/temperature.sh
```

```
#!/bin/bash
/usr/bin/vcgencmd measure_temp
```

```console
chmod +x ~/temperature.sh
```

Create shell script to spin down hard drives:
```console
vi ~/spindown.sh
```

```
#!/bin/bash
sudo hdparm -Y /dev/sda
sudo hdparm -Y /dev/sdb
sudo hdparm -Y /dev/sdc
sudo hdparm -Y /dev/sdd
```

```console
chmod +x ~/spindown.sh
```
