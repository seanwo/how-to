#!/bin/bash

# REFERENCES:
# https://drkbl.com/ubuntu-18-samba-time-machine/
# https://kirb.me/2018/03/24/using-samba-as-a-time-machine-network-server.html
# https://wa.rwick.com/2018/04/08/minimal-ubuntu-time-machine-backup-service/
# https://www.samba.org/samba/history/
# https://wiki.samba.org/index.php/Package_Dependencies_Required_to_Build_Samba
# https://simonwheatley.co.uk/2008/04/avahi-finder-icons/
# https://www.samba.org/samba/docs/current/man-html/vfs_fruit.8.html
# https://wiki.debian.org/CheckInstall

read -p "Press [Enter] key to update development system..."

sudo apt -y update
sleep 10s
sudo apt -y upgrade

read -p "Press [Enter] key to remove any older version of samba completely..."

sudo systemctl stop smbd
sudo systemctl stop nmbd
sudo apt -y remove samba samba-libs --purge
sudo apt -y autoremove

read -p "Press [Enter] key to get new samba sources..."

source_name="samba"
source_version="4.9.16"

cd ~
mkdir build
cd build
wget https://download.samba.org/pub/samba/stable/$source_name-$source_version.tar.gz
tar -xvf samba-*.tar.gz
cd samba-*/

read -p "Press [Enter] key to install samba build dependencies..."

wget -O bootstrap.sh "https://git.samba.org/?p=samba.git;a=blob_plain;f=bootstrap/generated-dists/ubuntu1804/bootstrap.sh;hb=v4-11-test"
chmod +x bootstrap.sh
sudo ./bootstrap.sh
sudo apt-get -y install avahi-daemon libavahi-client-dev libavahi-common-dev avahi-discover avahi-utils libnss-mdns mdns-scan

read -p "Press [Enter] key to configure and make samba..."

DEB_HOST_MULTIARCH=$(dpkg-architecture -qDEB_HOST_MULTIARCH)

./configure \
    --prefix=/usr \
    --exec-prefix=/usr \
    --with-systemd \
    --systemd-install-services \
    --sbindir=/usr/sbin \
    --bindir=/usr/bin \
    --libdir=/usr/lib/$DEB_HOST_MULTIARCH \
    --with-systemddir=/lib/systemd/system \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --with-privatedir=/var/lib/samba/private \
    --with-smbpasswd-file=/etc/samba/smbpasswd \
    --enable-fhs
    
make

read -p "Press [Enter] key to create samba package..."

sudo apt -y install checkinstall
fakeroot checkinstall --install=no --fstrans --pkgname="my$source_name" --pkgversion="$source_version" --maintainer="seanwo@gmail.com" -y -D make install

read -p "Press [Enter] key to install samba..."

sudo apt -y install samba-libs
sudo dpkg -i --force-all ./*.deb

read -p "Press [Enter] key to add timemachine share samba configuration..."

echo ""  | sudo tee -a /etc/samba/smb.conf
echo "[global]"  | sudo tee -a /etc/samba/smb.conf
echo "fruit:model = RackMac"  | sudo tee -a /etc/samba/smb.conf
echo "fruit:aapl = yes"  | sudo tee -a /etc/samba/smb.conf
echo ""  | sudo tee -a /etc/samba/smb.conf
echo "[TimeMachine Home]" | sudo tee -a /etc/samba/smb.conf
echo "    comment = Time Machine" | sudo tee -a /etc/samba/smb.conf
echo "    path = /var/samba/timemachine" | sudo tee -a /etc/samba/smb.conf
echo "    browseable = yes" | sudo tee -a /etc/samba/smb.conf
echo "    writeable = yes" | sudo tee -a /etc/samba/smb.conf
echo "    create mask = 0600" | sudo tee -a /etc/samba/smb.conf
echo "    directory mask = 0700" | sudo tee -a /etc/samba/smb.conf
echo "    spotlight = yes" | sudo tee -a /etc/samba/smb.conf
echo "    vfs objects = catia fruit streams_xattr" | sudo tee -a /etc/samba/smb.conf
echo "    fruit:time machine = yes" | sudo tee -a /etc/samba/smb.conf

sudo mkdir /var/samba/timemachine

read -p "Press [Enter] key to enable and start samba..."

sudo systemctl daemon-reload
sudo systemctl enable {nmb,smb,winbind}.service
sudo systemctl stop {nmb,smb,winbind}.service
sudo systemctl start {nmb,smb,winbind}.service