## Ubuntu 20.04 LTS (Operating System)

source: https://www.ubuntu.com/download/desktop

_The default user in these examples is called **mediauser** and the machine in these examples is called **mediabox**._

Instal Ubuntu 20.04 LTS by selecting "Normal installation", "Download updates while installing Ubuntu", and "Install third-party software...".

Set it to not require the user to login on startup.


Bring the system up-to-date:
```console
sudo apt update
sudo apt list --upgradeable
sudo apt upgrade
```
Reboot

## System Tweaks

In case you need to rename your machines:
```console
sudo hostname mediabox
sudo echo "mediabox" > /etc/hostname
sudo vi /etc/hosts
```
and update the name to mediabox:
```
127.0.0.1	localhost
127.0.1.1	mediabox

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```
Update your DHCP reservation hostname if you have one in your router.

Update screen saver timeout, screen locking, disable sleep and hibernate options (or use dconf-editor):
```console
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

If you have a UPS, tell the system to shutdown on critical battery levels:
```console
sudo vi /etc/UPower/UPower.conf
```
and update the following values:
```
UsePercentageForPolicy=true
PercentageLow=30
PercentageCritical=20
PercentageAction=15
CriticalPowerAction=PowerOff
```
and then restart the service
```console
sudo systemctl restart upower
```

If you are adding a NVIDIA GPU, identify the hardware:
```console
sudo apt install hwinfo
hwinfo --gfxcard --short
```

Find the latest drivers (in my case the latest was version 470):
```console
apt search nvidia-driver
sudo apt install nvidia-driver-470
sudo sync
sudo reboot
```

Check if the drivers are working:
```console
nvidia-smi
```

If the drivers are not connecting, try:
```console
sudo apt install linux-headers-$(uname -r)
sudo update-initramfs -u
sudo sync
sudo reboot
```

Tools for the drivers include:
```console
nvidia-smi; #use for monitoring
nvidia-settings; #use to view the configuration
sudo nvidia-settings; #use to change the configuration
```
