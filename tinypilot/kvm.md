## Install TinyPilot KVM Software

source: https://tinypilotkvm.com/blog/build-a-kvm-over-ip-under-100#how-to-build-your-own-tinypilot  

This will install TinyPilot KVM software on your Raspberry Pi so that you can control attached devices using hdmi and usb.
```console
curl -sS https://raw.githubusercontent.com/tiny-pilot/tinypilot/master/quick-install | bash -
sudo reboot
```

Access your new TinyPilot KVM at http://tinypilot (or http://[hostname] where hostname is the hostname you assigned the device and added to your router) (or http://192.168.0.xxx where the ip address is the address of your TinyPilot)
