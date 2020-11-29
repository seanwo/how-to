# Instructions for Running Juno Grade Monitoring
https://github.com/seanwo/juno

## Install the Latest Java8

Install Java8 JRE
```console
sudo apt install openjdk-8-jre-headless

java -version
```

## Add the Juno Application

```console
sudo mkdir /root/.juno
```

Add or create a /root/.juno/[config.xml](juno.config.xml)
Add the [juno.jar](juno.jar) to /root directory

```console
sudo vi /root/juno.sh
```
```
#!/bin/bash
/usr/bin/java -jar /root/juno.jar &> /var/log/juno.log
```
Make the file executable
```console
sudo chmod +x /root/juno.sh
```
Create a service definition
```console
sudo vi /etc/systemd/system/juno.service
```
```
[Unit]
Description=juno script
Requires=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/root/juno.sh

[Install]
WantedBy=multi-user.target
```
Enable the service and run the service
```console
sudo systemctl enable juno
sudo systemctl restart juno
```
