
## Install Chrome (Browser)

source: https://www.linuxbabe.com/ubuntu/install-google-chrome-ubuntu-18-04-lts

```console
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
