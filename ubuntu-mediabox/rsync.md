## Configure Drive Mirroring (Snapshot Media Drive)

source: https://superuser.com/questions/709176/how-to-best-clone-a-running-system-to-a-new-harddisk-using-rsync

```console
sudo su -
mkdir /var/log/rsync
sudo vi /root/sync.sh
```
Use the following file and update as appropriate for your accounts and directories:

[sync.sh](sync.sh)

Lock the script down:
```console
sudo chmod 0755 /root/sync.sh
```
Run at midnight daily as root:
```console
sudo crontab -e
```
```
0 0 * * * /root/sync.sh
```
