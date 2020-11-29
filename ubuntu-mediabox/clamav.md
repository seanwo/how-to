## Install ClamAV (Anti-Malware)

source: https://websiteforstudents.com/install-clamav-linux-antivirus-on-ubuntu-16-04-17-10-18-04-desktp/  
source: https://www.howtoforge.com/tutorial/configure-clamav-to-scan-and-notify-virus-and-malware/

```console
sudo apt install clamav clamav-daemon
sudo apt install clamtk
```
```console
sudo su -
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
