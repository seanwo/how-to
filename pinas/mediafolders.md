## Setup Media Shared Folders

source: https://kerneltalks.com/tips-tricks/how-to-change-uid-or-gid-safely-in-linux/  

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

CLI:

If you want to sync the ```mediauser``` account user id across systems for use with NFS, you will want to change the uid right after you create it.  For example, if you want to change the uid from 1000 to 2001:

```console
id mediauser
```
```
uid=1000(mediauser) gid=100(users) groups=100(users)
```
```console
sudo usermod -u 2001 mediauser
id mediauser
```
```
uid=2001(mediauser) gid=100(users) groups=100(users)
```

Now create each media folder on each data drive:

```console
cd /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/mergerfs-pool1
sudo mkdir Movies
sudo mkdir Music
sudo mkdir Pictures
sudo mkdir Recorded
sudo mkdir Shows
sudo mkdir Torrents
sudo mkdir Videos
sudo chown mediauser:users Movies
sudo chown mediauser:users Music
sudo chown mediauser:users Pictures
sudo chown mediauser:users Recorded
sudo chown mediauser:users Shows
sudo chown mediauser:users Torrents
sudo chown mediauser:users Videos
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
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Movies
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Music
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Pictures
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Recorded
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Shows
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Torrents
drwxrwxr-x  2 mediauser users 4096 Nov 20 14:34 Videos
```

Place a copy of [beautify.sh](beautify.sh) on /srv/ and make it executable:

```console
sudo vi /srv/beautify.sh
sudo chown root:root /srv/beautify.sh
sudo chmod +x /srv/beautify.sh
```

OMV6 GUI:

Storage>Shared Folders
* Name: ```Share```
* File system: mergerfs-pool1
* Relative path: ```Share/```
* Permissions: Administrators: read/write, Others: read/write, Others: read-only
* Comment:

_Repeat for each media folder_

Storage>Shared Folders>```Share Folder```>ACL
* Name: ```Share``` [on /dev/sd?1, share/]
* User/Group permissions: none
* Owner: ```mediauser``` Permissions: Read/Write/Execute
* Group: users Permissions: Read/Write/Execute
* Others: Read/Execute
* Replace: :white_check_mark:
* Recursive: :white_check_mark: (if you need to update a folder coming from another system) otherwise :x:

_Repeat for each media folder_

Storage>Shared Folders>```Shared Folder```>Privleges
* ```mediauser```: Read/Write

_Repeat for each media folder_

System>Scheduled Tasks>Create
* Time of execution: Certain date
* Enabled: :white_check_mark:
* Minute: 0
* Hour: 0
* Day of month: *
* Month: *
* Day of week: *
* User: root
* Command: /srv/beautify.sh
* Send command output via email: :x:
