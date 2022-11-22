## Setup Media Shared Folders

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

OMV6 GUI:

User Management>Users>Create
* Name: ```mediauser```
* Email:
* Password: ```[generate a strong random password]```
* Confirm Password:
* Shell: /bin/sh
* Groups: users
* SSH public keys: 
* Disallow account modification: :white_check_mark:
* Comment

Storage>Shared Folders
* Name: ```share```
* File system: mergerfs-pool1
* Relative path: ```share/```
* Permissions: Administrators: read/write, Others: read/write, Others: read-only
* Comment:

_Repeat for each media folder_

Storage>Shared Folders>```share```>ACL
* Name: ```share``` [on /dev/sd?1, share/]
* User/Group permissions: none
* Owner: ```mediauser``` Permissions: Read/Write/Execute
* Group: users Permissions: Read/Write/Execute
* Others: Read/Execute
* Replace: :white_check_mark:
* Recursive: :white_check_mark: (if you need to update a folder coming from another system) otherwise :x:

_Repeat for each media folder_

Storage>Shared Folders>```share```>Privleges
* ```mediauser```: Read/Write

_Repeat for each media folder_
