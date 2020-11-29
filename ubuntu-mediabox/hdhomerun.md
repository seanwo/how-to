## Install HDHomeRun (Antenna Tuner Drivers)

source: https://www.silicondust.com/support/linux/

```console
sudo apt update
sudo apt install build-essential
sudo apt install pkg-config
sudo apt install libgtk2.0-dev
sudo apt install libcanberra-gtk-module

cd ~/Downloads
wget http://download.silicondust.com/hdhomerun/libhdhomerun_20180817.tgz
wget http://download.silicondust.com/hdhomerun/hdhomerun_config_gui_20180817.tgz
mkdir hdhomerun
cp libhdhomerun_20180817.tgz hdhomerun
cp hdhomerun_config_gui_20180817.tgz hdhomerun
cd hdhomerun
tar -xvf libhdhomerun_20180817.tgz
tar -xvf hdhomerun_config_gui_20180817.tgz
cd hdhomerun_config_gui
./configure
make
sudo make install
sudo ldconfig
```
_Note: this installs the following files:_
```
/usr/local/bin/hdhomerun_config_gui
/usr/local/lib/libhdhomerun.so
/usr/local/bin/hdhomerun_config
```
Once PLEX is configured add the following channels:
```
14.1, 18.1, 18.2, 18.3, 18.4, 24.1, 24.3, 36.1, 36.2, 36.3, 42.1, 54.1, 54.2, 54.3, 62.3, 62.4, 14.3, 24.4
```
