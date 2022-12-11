
## Install Chrome (Browser)

source: https://www.linuxbabe.com/ubuntu/install-google-chrome-ubuntu-18-04-lts  
source: https://askubuntu.com/questions/867/how-can-i-stop-being-prompted-to-unlock-the-default-keyring-on-boot  

```console
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```

From the UI:
* Open Applications -> Accessories -> Password and Encryption Keys
* Right-click on the "login" keyring
* Select "Change password"
* Enter your old password and leave the new password blank
* Press ok, read the security warning, think about it and if you still want to get rid of this dialog, choose "use unsafe storage".
