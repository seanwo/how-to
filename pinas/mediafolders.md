## Setup Media Folders

CLI:

```console
cd /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/mergerfs-pool1
sudo mkdir movies
sudo mkdir music
sudo mkdir pictures
sudo mkdir recorded
sudo mkdir torrents
sudo mkdir videos
sudo chown mediauser:users movies
sudo chown mediauser:users music
sudo chown mediauser:users pictures
sudo chown mediauser:users recorded
sudo chown mediauser:users torrents
sudo chown mediauser:users videos
```
_Repeat for each data drive_

Verify that the mergerfs pool looks correct:
```console
ls -la /srv/mergerfs/mergerfs-pool1
```

```
total 20
drwxr-xr-x  5 root      root  4096 Nov 20 16:02 .
drwxrwxrwx  3 root      root  4096 Nov 20 14:15 ..
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 movies
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 music
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 pictures
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 recorded
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 torrents
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 videos
```
