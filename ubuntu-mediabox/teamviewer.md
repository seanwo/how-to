## Install TeamViewer (Remote Desktop)

source: https://community.teamviewer.com/t5/Knowledge-Base/How-to-update-TeamViewer-on-Linux-via-repository/ta-p/30666

```console
wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" >> /etc/apt/sources.list.d/teamviewer.list'
sudo apt update
sudo apt install teamviewer
```
When prompted choose to "install the package maintainer's version".  
Add your machine to your teamviewer account and then configure teamviewer at run at startup and grant easy access.
