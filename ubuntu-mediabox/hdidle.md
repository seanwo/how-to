## Install HD-IDLE (Drive Spin-Down)

source: http://hd-idle.sourceforge.net/  
source: https://forum.openmediavault.org/index.php/Thread/17101-Guide-How-to-setup-hd-idle-a-HDD-spin-down-SW-together-with-the-OMV-plugin-Autos/  
source: https://medium.com/@tamashudak/spin-down-hdd-with-raspberry-pi-using-hd-idle-7709e6c921f8
```console
cd ~/Downloads
mkdir hd-idle_download
cd hd-idle_download
wget sourceforge.net/projects/hd-idle/files/hd-idle-1.05.tgz
tar -xvf hd-idle-1.05.tgz
cd hd-idle
make
dpkg-buildpackage -rfakeroot
cd ..
sudo dpkg -i hd-idle_1.05_amd64.deb
```
Set the spin down time for all drives:
```console
sudo vi /etc/default/hd-idle
```
```
START_HD_IDLE=true
HD_IDLE_OPTS="-i 1800"
```
```console
sudo /etc/init.d/hd-idle start
```
