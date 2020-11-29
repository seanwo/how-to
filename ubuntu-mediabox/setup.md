# Instructions for (Re)Building My Home Ubuntu Server

![alt text](mediabox.jpg "mediabox")

[My Hardware Specs](hardware.md)  
[Install Ubuntu LTS](ubuntu.md)  
[Install Chrome](chrome.md)  
[Install TeamViewer](teamviewer.md)  
[Install HDHomeRun](hdhomerun.md)  
[Install Plex Media Server](plexmediaserver.md)  
[Install qBittorrent](qbittorrent.md)  
[Install SFTP Server](sftpserver.md)  
[Install Samba](samba.md)  
[Install Apple Time Machine Support](timemachine.md)  
[Install VLC](vlc.md)  
[Install HD-IDLE](hdidle.md)  
[Install Sensor Monitors](sensormonitors.md)  
[Install SMTP Client](smtp.md)  
[Setup Disk Structure](hdds.md)  
[Install ClamAV](clamav.md)  
[Setup Drive Mirroring](rsync.md)  
[Setup Juno Grade Monitoring](juno.md)  

## Duplicity w/ S3 (Encrypted Cloud Backup)

source: https://easyengine.io/tutorials/backups/duplicity-amazon-s3

_This assumes you have an AWS account and know how to use it._

AWS S3: Create a new non public bucket.  
AWS IAM: Create duplicity-backup programmatic user and store off the access and secret keys.  
AWS IAM: Create duplicity-backup policy (replace BUCKET_NAME with your real bucket name):
```
{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::BUCKET_NAME",
                "arn:aws:s3:::BUCKET_NAME/*"
            ]
        }
    ]
}
```
AWS IAM: Assign duplicity-backup policy to duplicity-backup user.

```console
sudo apt install duplicity
sudo apt install python-boto
```
Build your encryption public/private key:
```console
gpg --full-generate-key
```
Use the defaults.

real name: duplicity  
email: your real email  
comment: duplicity gpg key

Set a secure passphrase.

Export your keys:
```console
gpg --export -a "duplicity" > public.key
gpg --export-secret-key -a "duplicity" > private.key
```
**Backup these keys (along with the passphrase to unlock the secret key) in a secure location such as https://www.lastpass.com.**  Then remove the .key files.

```console
sudo mkdir /var/log/duplicity
sudo chown mediauser:mediauser /var/log/duplicity
```
```console
vi ~/backup.sh
```
Use the following file and update as appropriate for your accounts and directories:

[backup.sh](backup.sh)
```console
chmod +x ~/backup.sh
```
```console
vi ~/restore.sh
```
Use the following file and update as appropriate for your accounts and directories:

todo
```console
chmod +x ~/restore.sh
```
Run daily as mediauser at 4am
```console
crontab -e
```
```
0 4 * * * /home/mediauser/backup.sh >/dev/null 2>&1
```

## Final Configuration
* Configure tuners in PLEX.  My channels are: 14.1, 18.1, 18.2, 18.3, 18.4, 24.1, 24.3, 36.1, 36.2, 36.3, 42.1, 54.1, 54.2, 54.3, 62.3, 62.4, 14.3, 24.4.
* Copy any existing content to the new media drive structure.
* Configure PLEX Libraries (/mnt/media/Movies, /mnt/media/Recorded, /mnt/media/Torrents, /mnt/media/Videos)
* Configure qBittorrent RSS feed.
