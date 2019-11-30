#!/bin/bash

read -p "Press [Enter] key to update target system applications..."

sudo apt -y update
sleep 10s
sudo apt -y upgrade

read -p "Press [Enter] key to remove mysamba..."

sudo systemctl stop {nmb,smb,winbind}.service
sudo dpkg --purge mysamba

read -p "Press [Enter] key to repair default samba installation..."

sudo apt-mark unhold samba-libs
sudo apt-mark unhold libwbclient0
sudo apt -y remove samba-libs --purge
sudo apt -y install --reinstall libwbclient0
sudo apt -y install samba-libs
sudo apt -y install sambaz