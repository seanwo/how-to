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
