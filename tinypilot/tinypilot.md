## Build a TinyPilot KVM Switch 

source: https://tinypilotkvm.com/blog/build-a-kvm-over-ip-under-100#how-to-build-your-own-tinypilot  
source: https://www.geekyhacker.com/2021/02/15/configure-ssh-key-based-authentication-on-raspberry-pi/  
source: https://pimylifeup.com/raspberry-pi-update/  

Goto https://www.raspberrypi.com/software/ and get the imager tool or use brew to install it.

```console
brew install raspberry-pi-imager
```

Run the tool and select:  
Operating System: Raspberry Pi OS (other) -> Raspberry Pi OS Lite (32-bit). 
* Storage: Select your microSD card. 
* Settings:  
   * Set hostname: tinypilot. 
   * Enable SSH: Use password authentication. 
   * Set username and password: tinypilot/[secure password]. 
   * Set lcoale settings: Time zone: [your timez one]. 
* Select Write to image the card.  

Put the card in the raspberry pi and boot it up on the network.  
Check your router for the ip address that it aquired.  Optionally assign the mac address to a reserved dhcp ip address and cname it to tinypilot.  

Update the OS and packages:  

```console 
ssh tinypilot@tinypilot
```

```console
sudo apt update
sudo apt full-upgrade
sudo reboot
```
Update the bootloader

```console 
ssh tinypilot@tinypilot
```

Check if the bootloader is up-to-date:  
```console
sudo rpi-eeprom-update
```

If the bootloader is not up-to-date:  
```console
sudo rpi-eeprom-update -a
sudo reboot
```

Generate an RSA keypair (id_rsa_tinypilot & id_rsa_tinypilot.pub) and then copy the public key to the device:  
```console
ssh-copy-id -i ~/.ssh/id_rsa_tinypilot.pub tinypilot@tinypilot
```

Remove the ablity login with a password (only using rsa private key):  

```console
sudo vim /etc/ssh/sshd_config
```

Change the following parameters in the file:  
```
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
```

```console
sudo systemctl reload sshd
```

Confirm that you can only ssh with the rsa private key and not passwords.  To login with the rsa private key use this command from the client:  
```console
ssh -i ~./ssh/id_rsa_tinypilot tinypilot@tinypilot
```

Install TinyPilot software:  
 
```console
curl -sS https://raw.githubusercontent.com/tiny-pilot/tinypilot/master/quick-install | bash -
sudo reboot
```

Access your new TinyPilot KVM at http://tinypilot or http://[hostname you assigned the device]
