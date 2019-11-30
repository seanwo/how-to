#!/bin/bash

read -p "Press [Enter] key to update development system..."

sudo apt -y update
sleep 10s
sudo apt -y upgrade

read -p "Press [Enter] key to remove any older version of samba..."

sudo systemctl stop smbd
sudo systemctl stop nmbd
sudo apt -y remove mysamba --purge
sudo apt -y remove samba --purge
sudo apt -y remove samba-libs --purge
sudo apt -y autoremove

read -p "Press [Enter] key to install mysamba..."

wget https://github.com/seanwo/how-to/raw/master/ubuntu-mediabox/mysamba_4.9.16-1_amd64.deb
sudo apt -y install samba-libs
sudo dpkg -i --force-all ./*.deb
sudo apt-mark hold samba-libs

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
