## Install Samba Server (Local Windows Network Access)

source: https://tutorials.ubuntu.com/tutorial/install-and-configure-samba#0  
source: https://websiteforstudents.com/create-private-samba-share-ubuntu-17-04-17-10/
```console
sudo apt update
sudo apt install samba
sudo groupadd samba_users
sudo mkdir -p /var/samba/media
sudo mkdir -p /var/samba/pictures
sudo chown root:root /var/samba
sudo chown root:samba_users /var/samba/media
sudo chown root:samba_users /var/samba/pictures
sudo chmod 755 /var/samba
sudo chmod 775 /var/samba/media
sudo chmod 775 /var/samba/pictures
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
```
Create a new Samba configuration file:
```console
sudo vi /etc/samba/smb.conf:
```
```
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = mediabox
security = user
map to guest = bad user
name resolve order = bcast host
dns proxy = no
bind interfaces only = yes

[media]
   path = /var/samba/media
   writable = yes
   guest ok = no
   read only = no
   browsable = yes
   create mode = 0755
   directory mode = 0755
   valid users = @samba_users

[pictures]
   path = /var/samba/pictures
   writable = yes
   guest ok = no
   read only = no
   browsable = yes
   create mode = 0755
   directory mode = 0755
   valid users = @samba_users
```
Put mediauser in the samba_users group:
```console
sudo usermod -aG samba_users mediauser
```
Set a password you feel comfortable using on your windows network for this user (Do *not* use the same password you use for system login for security reasons):
```console
sudo smbpasswd -a mediauser
```
```console
sudo systemctl restart smbd
```
