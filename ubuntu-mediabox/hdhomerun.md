## Install HDHomeRun

source: https://www.silicondust.com/support/linux/

```console
sudo apt update
sudo apt install build-essential
sudo apt install pkg-config
sudo apt install libgtk2.0-dev
sudo apt install libcanberra-gtk-module

cd ~/Downloads
wget https://download.silicondust.com/hdhomerun/libhdhomerun_20221205.tgz
wget https://download.silicondust.com/hdhomerun/hdhomerun_config_gui_20221205.tgz
mkdir hdhomerun
cp libhdhomerun_20221205.tgz hdhomerun
cp hdhomerun_config_gui_20221205.tgz hdhomerun
cd hdhomerun
tar -xvf libhdhomerun_20221205.tgz
tar -xvf hdhomerun_config_gui_20221205.tgz
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
