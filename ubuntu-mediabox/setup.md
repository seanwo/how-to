
# Ubuntu LTS

source: https://www.ubuntu.com/download/desktop

_The default user in these examples is called mediauser and he machine in these examples is called mediabox._

Install the latest Ubuntu LTS using the "Minimal install option".

Set it to not require the user to login on startup.

Bring the system up-to-date:
```console
sudo apt update
sudo apt list --upgradeable
sudo apt upgrade
```
Reboot for good measure.

# System Tweaks

In case you need to rename your machines:
```console
sudo hostname mediabox
```
```console
sudo echo "mediabox" > /etc/hostname
```
```console
sudo vi /etc/hosts
```
and update to mediabox
```
127.0.0.1	localhost
127.0.1.1	mediabox

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

Update screen saver timeout, screen locking, disable sleep and hibernate options:
```console
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```
Update your dhcp reservation hostname if you have one in your router.

# Install Chrome

source: https://www.linuxbabe.com/ubuntu/install-google-chrome-ubuntu-18-04-lts

```console
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```

# Install TeamViewer

source: https://community.teamviewer.com/t5/Knowledge-Base/How-to-update-TeamViewer-on-Linux-via-repository/ta-p/30666

```console
wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" >> /etc/apt/sources.list.d/teamviewer.list'
sudo apt update
sudo apt install teamviewer
```
Add your machine to your teamviewer account and configure teamviewer at run at startup.

# Install HDHomeRun

source: https://www.silicondust.com/support/linux/

```console
sudo apt update
sudo apt install build-essential
sudo apt install pkg-config
sudo apt install libgtk2.0-dev
sudo apt install libcanberra-gtk-module

cd ~/Downloads
wget http://download.silicondust.com/hdhomerun/libhdhomerun_20180817.tgz
wget http://download.silicondust.com/hdhomerun/hdhomerun_config_gui_20180817.tgz
mkdir hdhomerun
cp libhdhomerun_20180817.tgz hdhomerun
cp hdhomerun_config_gui_20180817.tgz hdhomerun
cd hdhomerun
tar -xvf libhdhomerun_20180817.tgz
tar -xvf hdhomerun_config_gui_20180817.tgz
cd hdhomerun_config_gui
./configure
make
sudo make install
sudo ldconfig
```
Note: this installs the following files:
```
/usr/local/bin/hdhomerun_config_gui
/usr/local/lib/libhdhomerun.so
/usr/local/bin/hdhomerun_config
```

# Install Plex Media Server

source: https://linoxide.com/linux-how-to/install-plex-media-server-ubuntu/

```console
wget -q -O - https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo sh -c 'echo "deb https://downloads.plex.tv/repo/deb public main" >> /etc/apt/sources.list.d/plexmediaserver.list'
sudo apt update
sudo apt install plexmediaserver
systemctl enable plexmediaserver
systemctl start plexmediaserver
```

Goto http://localhost:32400/web/

```console
sudo vi /etc/apt/sources.list.d/plexmediaserver.list
```
and uncomment out the the repo which was clobbered during the install:
```
# When enabling this repo please remember to add the PlexPublic.Key into the apt setup.
# wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -
deb https://downloads.plex.tv/repo/deb/ public main
```

***************************
*** Install qBittorrent ***
***************************
#source: https://www.linuxbabe.com/ubuntu/install-qbittorrent-ubuntu-18-04-desktop-server

sudo sh -c 'echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu bionic main" >> /etc/apt/sources.list.d/qbittorrent-team-ubuntu-qbittorrent-stable-bionic.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D35164147CA69FC4
sudo apt update
sudo apt install qbittorrent

#set qbittorrent to autostart with system
gnome-session-properties
#Name: qBittorrent
#Command: /usr/bin/qbittorrent

#configure the client with PIA proxy settings.
#tell the system to use the proxy only for torrents; there are problems using it with RSS feeds
#after configuring the PIA proxy, check your torrent ip using https://torguard.net/checkmytorrentipaddress.php

cd ~/Downloads
wget http://upd.emule-security.org/ipfilter.zip
unzip ipfilter.zip
mv guarding.p2p ../guarding.dat
#add guarding.dat to ip filter list under connections

***************************
*** Install SFTP Server ***
***************************
#source: https://websiteforstudents.com/setup-retrictive-sftp-with-chroot-on-ubuntu-16-04-17-10-and-18-04/

sudo apt update
sudo apt install openssh-server
sudo systemctl stop ssh.service
sudo systemctl enable ssh.service
sudo systemctl start ssh.service

#edit sudo vi /etc/ssh/sshd_config
#remove or comment out the following line:
Subsystem      sftp    /usr/lib/openssh/sftp-server

#add the following lines:

Subsystem sftp internal-sftp

AllowUsers sftpuser
Match Group sftp_users
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /var/sftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no

sudo systemctl restart ssh.service
sudo groupadd sftp_users
sudo adduser sftpuser
#set a strong password you can use connecting externally.
sudo usermod -aG sftp_users sftpuser

sudo mkdir -p /var/sftp/uploads
sudo mkdir -p /var/sftp/downloads
sudo chown root:root /var/sftp
sudo chmod 755 /var/sftp
sudo chown root:sftp_users /var/sftp/uploads
sudo chown root:sftp_users /var/sftp/downloads
sudo chmod 775 /var/sftp/uploads
sudo chmod 755 /var/sftp/downloads

****************************
*** Install Samba Server ***
****************************
#source: https://tutorials.ubuntu.com/tutorial/install-and-configure-samba#0
#source: https://websiteforstudents.com/create-private-samba-share-ubuntu-17-04-17-10/

sudo apt update
sudo apt install samba
sudo groupadd samba_users
sudo mkdir -p /var/samba/media
sudo chown root:root /var/samba
sudo chown root:samba_users /var/samba/media
sudo chmod 755 /var/samba
sudo chmod 775 /var/samba/media
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak

#create sudo vi /etc/samba/smb.conf:

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
   create mode = 0777
   directory mode = 0777
   valid users = @samba_users

sudo usermod -aG samba_users mediauser
sudo smbpasswd -a mediauser
#set a password you feel comfortable using on your windows network for this user; does not share password with system password
sudo systemctl restart smbd

*******************
*** Install VLC ***
*******************

sudo apt update
sudo apt install vlc

***********************
*** Install HD-IDLE ***
***********************
#source: http://hd-idle.sourceforge.net/
#source: https://forum.openmediavault.org/index.php/Thread/17101-Guide-How-to-setup-hd-idle-a-HDD-spin-down-SW-together-with-the-OMV-plugin-Autos/
#source: https://medium.com/@tamashudak/spin-down-hdd-with-raspberry-pi-using-hd-idle-7709e6c921f8

cd ~/Downloads
mkdir hd-idle_download
cd hd-idle_download
wget sourceforge.net/projects/hd-idle/files/hd-idle-1.05.tgz

tar -xvf hd-idle-1.05.tgz
cd hd-idle
make
dpkg-buildpackage -rfakeroot
cd ..
sudo dpkg -i hd-idle_1.05_amd64.deb

#edit sudo vi etc/default/hd-idle

START_HD_IDLE=true
HD_IDLE_OPTS="-i 1800"
#1800 seconds of idle before spinning down all drives

sudo /etc/init.d/hd-idle start

***************************
*** Install SMTP Client ***
***************************
#source: https://www.linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu/

#create a gmail account; in this example we use email@gmail.com; replace with your user and real password below
sudo apt install postfix
# edit sudo vi /etc/postfix/sasl/sasl_passwd
[smtp.gmail.com]:587 email@gmail.com:password

sudo postmap /etc/postfix/sasl/sasl_passwd
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db

#update sudo vi /etc/postfix/main.cf
relayhost = [smtp.gmail.com]:587

#add to end sudo vi /etc/postfix/main.cf
# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

sudo systemctl restart postfix

sudo apt install mailutils

#test that you have email through gmail working; example sends a sample message to seanwo@gmail.com; send it to yourself instead.
echo "body" | mail -s "subject" email@gmail.com

****************************
*** SETUP DISK STRUCTURE ***
****************************

#assumes you have an external USB drive you are going to store your media on:

lsblk
# find disk to use for media; in this example it is /dev/sdc
# sudo fdisk /dev/sdc
# select g,n,w
# sudo mkfs.ext4 /dev/sdc1

#get UUID
sudo blkid /dev/sdc1

sudo mkdir /mnt/media

#edit sudo vi /etc/fstab
#we are going to identify the dirve via UUID and use extended acls.  we need to use nofail since it is usb and give a reasonable spinup timeout
UUID=d3ce0032-b588-44fb-9b4d-48c6886a45c5	/mnt/media	ext4	nofail,x-systemd.device-timeout=120,acl	0	0

sudo addgroup media
sudo usermod -a -G media mediauser
sudo usermod -a -G media plex


cd /mnt/media
sudo mkdir Movies
sudo mkdir Music
sudo mkdir Pictures
sudo mkdir Recorded
sudo mkdir Torrents
sudo mkdir TorrentTemp
sudo mkdir Videos
sudo chown mediauser:media Movies
sudo chown mediauser:media Music
sudo chown mediauser:media Pictures
sudo chown mediauser:media Recorded
sudo chown mediauser:media Torrents
sudo chown mediauser:media TorrentTemp
sudo chown mediauser:media Videos
sudo chmod u+rwx,g+rwxs,o+rx Movies
sudo chmod u+rwx,g+rwxs,o+rx Music
sudo chmod u+rwx,g+rwxs,o+rx Pictures
sudo chmod u+rwx,g+rwxs,o+rx Recorded
sudo chmod u+rwx,g+rwxs,o+rx Torrents
sudo chmod u+rwx,g+rwxs,o+rx TorrentTemp
sudo chmod u+rwx,g+rwxs,o+rx Videos

#we want all these directories and file to be part of the media group regardless of who puts files in them for playback and backup purposes.
sudo setfacl -Rdm g:media:rwx Movies
sudo setfacl -Rdm g:media:rwx Music
sudo setfacl -Rdm g:media:rwx Pictures
sudo setfacl -Rdm g:media:rwx Recorded
sudo setfacl -Rdm g:media:rwx Torrents
sudo setfacl -Rdm g:media:rwx TorrentTemp
sudo setfacl -Rdm g:media:rwx Videos

#use bind mounts to isolate what is available via sftp and samba (windows networking)
#edit sudo vi /etc/fstab
/mnt/media/Movies	/var/sftp/downloads/movies	none	defaults,bind	0	0
/mnt/media/Torrents	/var/sftp/downloads/torrents	none	defaults,bind	0	0
/mnt/media/Torrents	/var/samba/media	none	defaults,bind	0	0

**********************
*** Install ClamAV ***
**********************
#source: https://websiteforstudents.com/install-clamav-linux-antivirus-on-ubuntu-16-04-17-10-18-04-desktp/
#source: https://www.howtoforge.com/tutorial/configure-clamav-to-scan-and-notify-virus-and-malware/

sudo apt install clamav clamav-daemon
sudo apt install clamtk

#create sudo vi /root/clamscan.sh
#excluding /sys, mounts and bind mount locations

******************************************************************************************
#!/bin/bash
LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').txt";
EMAIL_MSG="Please see the log file attached.";
EMAIL_FROM="email@gmail.com";
EMAIL_TO="email@gmail.com";
EXCLUDE_DIRS="/sys/|/mnt/|/media/|/var/sftp/|/var/samba/";

echo "Starting a scan of $HOSTNAME.";

clamscan --exclude-dir="$EXCLUDE_DIRS" -r -i / >> "$LOGFILE";

MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);

if [ "$MALWARE" -ne "0" ];then
echo "$EMAIL_MSG" | mail -A "$LOGFILE" -s "Malware Found on $HOSTNAME" -aFrom:"$EMAIL_FROM" "$EMAIL_TO";
fi 

exit 0
******************************************************************************************

#lock the script down
sudo chmod 0755 /root/clamscan.sh

#run the weekly as root on Sunday at 2am 
sudo crontab -e
0 2 * * 0 /root/clamscan.sh >/dev/null 2>&1

#no: sudo ln /root/clamscan.sh /etc/cron.weekly/clamscan_weekly

***********************
*** Duplicity w/ S3 ***
***********************
#source: https://easyengine.io/tutorials/backups/duplicity-amazon-s3

#primarily to backup my pictures and music!

#AWS S3 to create new non public bucket
#AWS IAM to create duplicity-backup programmatic user and store the access key and secret key
#AWS IAM to create policy duplicity-backup (replace BUCKET_NAME with real bucket name):

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

#AWS IAM to assign duplicity-backup policy to duplicity-backup user

sudo apt install duplicity
sudo apt install python-boto

gpg --full-generate-key
#use defaults, real name: duplicity, email: your email, comment: duplicity gpg key
#set passphrase

gpg --export -a "duplicity" > public.key
gpg --export-secret-key -a "duplicity" > private.key
#backup these keys along with the passphrase in a secure location

#create a place where media user log backup results to
sudo mkdir /var/log/duplicity
sudo chown mediauser:mediauser /var/log/duplicity

#vi ~/backup.sh

******************************************************************************************
#!/bin/bash

# Export some ENV variables so you don't have to type anything
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export PASSPHRASE=""

# Your GPG key
GPG_KEY=

# The S3 destination followed by bucket name
DEST="s3://s3.amazonaws.com//BUCKETNAME/"

LOGFILE="/var/log/duplicity/backup.log"
DAILYLOGFILE="/var/log/duplicity/backup.daily.log"
HOST=`hostname`
DATE=`date +%Y-%m-%d`
MAILADDR="email@gmail.com"
TODAY=$(date +%d%m%Y)
OLDER_THAN="6M"
FULL_OLDER_THAN="3M"
SOURCE=/

is_running=$(ps -ef | grep duplicity  | grep python | wc -l)

if [ ! -d /var/log/duplicity ];then
    mkdir -p /var/log/duplicity
fi

if [ $is_running -eq 0 ]; then

    cat /dev/null > ${DAILYLOGFILE}

    duplicity \
    	--full-if-older-than ${FULL_OLDER_THAN} \
        --encrypt-key=${GPG_KEY} \
        --sign-key=${GPG_KEY} \
        --include=/mnt/media/Pictures \
        --include=/mnt/media/Music \
        --exclude=/** \
        ${SOURCE} ${DEST} >> ${DAILYLOGFILE} 2>&1

    duplicity remove-older-than ${OLDER_THAN} ${DEST} >> ${DAILYLOGFILE} 2>&1

    cat "$DAILYLOGFILE" | mail -s "Duplicity Backup Log for $HOST - $DATE" $MAILADDR

    cat "$DAILYLOGFILE" >> $LOGFILE

fi

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset PASSPHRASE
******************************************************************************************
chmod +x ~/backup.sh

#vi ~/restore.sh
******************************************************************************************

******************************************************************************************
chmod +x ~/restore.sh

#run daily as mediauser at 4am
crontab -e
0 4 * * * /home/mediauser/backup.sh >/dev/null 2>&1

***************
*** Cleanup ***
***************
sudo rm -rf /etc/apt/sources.list.d/*.dpkg-old

***************************
*** Final Configuration ***
***************************
+ Setup HDHomeRun Tunners in PLEX (14.1, 18.1, 18.2, 18.3, 18.4, 24.1, 24.3, 36.1, 36.2, 36.3, 42.1, 54.1, 54.2, 54.3, 62.3, 62.4, 14.3, 24.4)
+ Configure PLEX Libraries (/mnt/media/Movies, /mnt/media/Recorded, /mnt/media/Torrents, /mnt/media/Videos)
+ Configure qBittorrent RSS feed
+ Convert USB NTFS Media Drive to USB Ext4 Media Drive

************
*** TODO ***
************

# dual drive sync for local backup
