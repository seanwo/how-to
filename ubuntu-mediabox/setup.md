# Instructions for Building an Ubuntu Plex Media System

## Ubuntu LTS (Operating System)

source: https://www.ubuntu.com/download/desktop

_The default user in these examples is called **mediauser** and the machine in these examples is called **mediabox**._

Install the latest Ubuntu LTS using the "Minimal install option".

Set it to not require the user to login on startup.

Bring the system up-to-date:
```console
sudo apt update
sudo apt list --upgradeable
sudo apt upgrade
```
Reboot for good measure.

## System Tweaks

In case you need to rename your machines:
```console
sudo hostname mediabox
sudo echo "mediabox" > /etc/hostname
sudo vi /etc/hosts
```
and update the name to mediabox:
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
Add support for exFat drives:
```console
sudo apt install exfat-fuse exfat-utils
```
Update your DHCP reservation hostname if you have one in your router.

## Install Chrome (Browser)

source: https://www.linuxbabe.com/ubuntu/install-google-chrome-ubuntu-18-04-lts

```console
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```

## Install TeamViewer (Remote Desktop)

source: https://community.teamviewer.com/t5/Knowledge-Base/How-to-update-TeamViewer-on-Linux-via-repository/ta-p/30666

```console
wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" >> /etc/apt/sources.list.d/teamviewer.list'
sudo apt update
sudo apt install teamviewer
```
Add your machine to your teamviewer account and configure teamviewer at run at startup.

## Install HDHomeRun (Antenna Tuner Drivers)

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
_Note: this installs the following files:_
```
/usr/local/bin/hdhomerun_config_gui
/usr/local/lib/libhdhomerun.so
/usr/local/bin/hdhomerun_config
```

## Install Plex Media Server (Media Server)

source: https://linoxide.com/linux-how-to/install-plex-media-server-ubuntu/

```console
wget -q -O - https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo sh -c 'echo "deb https://downloads.plex.tv/repo/deb public main" >> /etc/apt/sources.list.d/plexmediaserver.list'
sudo apt update
sudo apt install plexmediaserver
systemctl enable plexmediaserver
systemctl start plexmediaserver
```

Goto http://localhost:32400/web/ and confirm you have a running Plex server.  Sign into your Plex account.

```console
sudo vi /etc/apt/sources.list.d/plexmediaserver.list
```
and uncomment out the the repo which was clobbered during the install:
```
# When enabling this repo please remember to add the PlexPublic.Key into the apt setup.
# wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -
deb https://downloads.plex.tv/repo/deb/ public main
```

## Install qBittorrent (Supplemental Content from Legal Sources)

source: https://www.linuxbabe.com/ubuntu/install-qbittorrent-ubuntu-18-04-desktop-server

```console
sudo sh -c 'echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu bionic main" >> /etc/apt/sources.list.d/qbittorrent-team-ubuntu-qbittorrent-stable-bionic.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D35164147CA69FC4
sudo apt update
sudo apt install qbittorrent
```

Set qbittorrent to autostart with system:
```console
gnome-session-properties
```

Name: qBittorrent  
Command: /usr/bin/qbittorrent

Configure the client with your proxy settings such as one provided by https://www.privateinternetaccess.com.

[Sample QBitTorrent Configuration](qbittorent.preferences.md)

After configuring the you proxy, check your torrent ip using https://torguard.net/checkmytorrentipaddress.php and make sure it is showing the ip address of the proxy torrent; not the one returned by https://www.whatsmyip.org.

Apply an IP filter list:
```console
cd ~/Downloads
wget http://upd.emule-security.org/ipfilter.zip
unzip ipfilter.zip
mv guarding.p2p ../guarding.dat
```
Add /home/mediauser/guarding.dat to the ip filter list in qbittorent under connections.

## Install SFTP Server (Secure Remote File Access)

source: https://websiteforstudents.com/setup-retrictive-sftp-with-chroot-on-ubuntu-16-04-17-10-and-18-04/

```console
sudo apt update
sudo apt install openssh-server
sudo systemctl stop ssh.service
sudo systemctl enable ssh.service
sudo systemctl start ssh.service
```

```console
sudo vi /etc/ssh/sshd_config
```
Remove or comment out the following line:
```
Subsystem      sftp    /usr/lib/openssh/sftp-server
```
and add the following lines:
```
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
```
```console
sudo systemctl restart ssh.service
```
Set a strong password you can use to connect to sftp externally:
```console
sudo adduser sftpuser
sudo groupadd sftp_users
sudo usermod -aG sftp_users sftpuser
```
Setup the restricted root for SFTP:
```console
sudo mkdir -p /var/sftp/uploads
sudo mkdir -p /var/sftp/downloads
sudo chown root:root /var/sftp
sudo chmod 755 /var/sftp
sudo chown root:sftp_users /var/sftp/uploads
sudo chown root:sftp_users /var/sftp/downloads
sudo chmod 775 /var/sftp/uploads
sudo chmod 755 /var/sftp/downloads
```

## Install Samba Server (Local Windows Network Access)

source: https://tutorials.ubuntu.com/tutorial/install-and-configure-samba#0  
source: https://websiteforstudents.com/create-private-samba-share-ubuntu-17-04-17-10/
```console
sudo apt update
sudo apt install samba
sudo groupadd samba_users
sudo mkdir -p /var/samba/media
sudo mkidr -p /var/samba/pictures
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

## Install VLC (Video Playback)

```console
sudo apt update
sudo apt install vlc
```

## Install HD-IDLE (Drive Spin-Down)

source: http://hd-idle.sourceforge.net/  
source: https://forum.openmediavault.org/index.php/Thread/17101-Guide-How-to-setup-hd-idle-a-HDD-spin-down-SW-together-with-the-OMV-plugin-Autos/  
source: https://medium.com/@tamashudak/spin-down-hdd-with-raspberry-pi-using-hd-idle-7709e6c921f8
```console
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
```
Set the spin down time for all drives:
```console
sudo vi etc/default/hd-idle
```
```
START_HD_IDLE=true
HD_IDLE_OPTS="-i 1800"
```
```console
sudo /etc/init.d/hd-idle start
```

## Install SMTP Client (Outbound Email)

source: https://www.linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu/

Create a new gmail account. (In this example we use email@gmail.com; replace this with your new gmail address and real password)

```console
sudo apt install postfix
```
Configure postfix with your new gmail account:
```console
sudo vi /etc/postfix/sasl/sasl_passwd
```
```
[smtp.gmail.com]:587 email@gmail.com:password
```
```console
sudo postmap /etc/postfix/sasl/sasl_passwd
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```
```console
sudo vi /etc/postfix/main.cf
```
Update the relayhost:
```
relayhost = [smtp.gmail.com]:587
```
and then add the following lines:
```
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
```
```console
sudo systemctl restart postfix
sudo apt install mailutils
```
Test that you can send email:
```console
echo "body" | mail -s "subject" test@email.com
```
where test@email.com is a different email account where you can confirm receipt of a test email.

## Setup Media Disk Structure (Media Content)

This part assumes you have an external USB drive you are going to store your media on:

```console
lsblk
```
Find disk to use for media (in this example it is /dev/sdc)
```
sda      8:16   0 465.8G  0 disk 
└─sda1   8:17   0 465.8G  0 part /
sdc      8:48   0   3.7T  0 disk 
```
**Warning:** this repartions the disk; be careful!:
```console
sudo fdisk /dev/sdc
```
Use the commands g, n, w.

**Warning:** this formats the disk; be careful!:
```console
sudo mkfs.ext4 /dev/sdc1
```
Get the UUID of this disk:
```console
sudo blkid /dev/sdc1
```
```
/dev/sdc1: UUID="d3ce0032-b588-44fb-9b4d-48c6886a45c5" TYPE="ext4" PARTUUID="4fcc82ea-9297-3740-b41e-c089c5516c32"
```
Create a mount point:
```console
sudo mkdir /mnt/media
```
```console
sudo vi /etc/fstab
```
add the following line (replacing it with your UUID):
```
UUID=d3ce0032-b588-44fb-9b4d-48c6886a45c5	/mnt/media	ext4	nofail,x-systemd.device-timeout=120,acl	0	0
```
Create a media group and add our default and plex users to it:
```console
sudo addgroup media
sudo usermod -a -G media mediauser
sudo usermod -a -G media plex
```
Apply the layout:
```console
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
sudo mkdir Uploads
sudo chown root:sftp_users Uploads
sudo chmod 775 Uploads
```
We want the following directories and files to be part of the media group regardless of who puts files in them for playback and backup purposes:
```console
sudo setfacl -Rdm g:media:rwx Movies
sudo setfacl -Rdm g:media:rwx Music
sudo setfacl -Rdm g:media:rwx Pictures
sudo setfacl -Rdm g:media:rwx Recorded
sudo setfacl -Rdm g:media:rwx Torrents
sudo setfacl -Rdm g:media:rwx TorrentTemp
sudo setfacl -Rdm g:media:rwx Videos
```
Use bind mounts to restrict what is available via sftp and samba (windows networking).
```console
sudo vi /etc/fstab
```
add:
```
/mnt/media/Movies	/var/sftp/downloads/movies	none	defaults,bind	0	0
/mnt/media/Torrents	/var/sftp/downloads/torrents	none	defaults,bind	0	0
/mnt/media/Uploads	/var/sftp/uploads	none	defaults,bind	0	0
/mnt/media/Torrents	/var/samba/media	none	defaults,bind	0	0
/mnt/media/Pictures	/var/samba/pictures	none	defaults,bind	0	0
```

## Install ClamAV (Anti-Malware)

source: https://websiteforstudents.com/install-clamav-linux-antivirus-on-ubuntu-16-04-17-10-18-04-desktp/  
source: https://www.howtoforge.com/tutorial/configure-clamav-to-scan-and-notify-virus-and-malware/

```console
sudo apt install clamav clamav-daemon
sudo apt install clamtk
```
```console
sudo vi /root/clamscan.sh
```
Use the following file and update as appropriate for your accounts and directories:

[clamscan.sh](clamscan.sh)

Lock the script down:
```console
sudo chmod 0755 /root/clamscan.sh
```
Run weekly as root on Sunday at 2am:
```console
sudo crontab -e
```
```
0 2 * * 0 /root/clamscan.sh >/dev/null 2>&1
```

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

## Cleanup
```console
sudo rm -rf /etc/apt/sources.list.d/*.dpkg-old
```

## Final Configuration
* Configure tuners in PLEX.  My channels are: 14.1, 18.1, 18.2, 18.3, 18.4, 24.1, 24.3, 36.1, 36.2, 36.3, 42.1, 54.1, 54.2, 54.3, 62.3, 62.4, 14.3, 24.4.
* Copy any existing content to the new media drive structure.
* Configure PLEX Libraries (/mnt/media/Movies, /mnt/media/Recorded, /mnt/media/Torrents, /mnt/media/Videos)
* Configure qBittorrent RSS feed.

## TODO
* Nightly sync of media drive to redundant local backup drive.
