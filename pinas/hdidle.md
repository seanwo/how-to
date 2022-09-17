## Install HD-IDLE

source: http://hd-idle.sourceforge.net/  
source: https://forum.openmediavault.org/index.php/Thread/17101-Guide-How-to-setup-hd-idle-a-HDD-spin-down-SW-together-with-the-OMV-plugin-Autos/  
source: https://medium.com/@tamashudak/spin-down-hdd-with-raspberry-pi-using-hd-idle-7709e6c921f8  

Many older drivers can not be set to spin down on a timer with hdparm so the solution is keep the spindown disabled in OMV and use hd-idle to spin your drive down while not in use.  If you are setting up an active RAID, you don't want to do this but I plan on using SnapRAID and I want my drives spun down as much as possible to keep the noise levels low.  

Installing the latest hd-idle package:
```console
sudo apt install wget
sudo apt install lsb-release
wget -O -  http://adelolmo.github.io/andoni.delolmo@gmail.com.gpg.key | sudo apt-key add -
echo "deb http://adelolmo.github.io/$(lsb_release  -cs) $(lsb_release -cs) main" | sudo tee  /etc/apt/sources.list.d/adelolmo.github.io.list
sudo apt update
sudo apt install hd-idle
```
Edit the hd-idle configuration file:
```console
sudo vi /etc/default/hd-idle
```
Make the following changes:
```
START_HD_IDLE=true
HD_IDLE_OPTS="-i 300 -l /var/log/hd-idle.log"
```
Set hd-idle to run as a service:
```console
sudo systemctl unmask hd-idle
sudo systemctl start hd-idle
sudo systemctl enable hd-idle
```
