## Install Apple Time Machine Samba Support

Create a Time Machine user:
```console
sudo adduser tmuser
sudo groupadd tm_users
sudo usermod -aG tm_users tmuser
sudo smbpasswd -a tmuser
```
Setup a Time Machine share point:
```console
sudo mkdir -p /var/samba/timemachine
sudo chown root:tm_users /var/samba/timemachine
sudo chmod 775 /var/samba/timemachine
```
Add the following lines to the end of your smb.conf
```console
sudo vi /etc/samba/smb.conf
```
```
[global]
fruit:model = RackMac
fruit:aapl = yes

[TimeMachine Home]
    comment = Time Machine
    path = /var/samba/timemachine
    browseable = yes
    writeable = yes
    create mask = 0600
    directory mask = 0700
    spotlight = yes
    vfs objects = catia fruit streams_xattr
    fruit:time machine = yes
    valid users = @tm_users
```
Restart the Samba service:
```console
sudo systemctl restart smbd
```
