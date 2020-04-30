# Instructions for Running Juno

## Install the Latest Java7

Get the latest version of Java7 from archives: https://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html

Install Java7 and set alternatives
```console
sudo mkdir /usr/local/java
sudo cd /usr/local/java
sudo tar -xvf jdk-7u80-linux-x64.tar.gz

sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk1.7.0_80/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk1.7.0_80/bin/javac" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jdk1.7.0_80/bin/javaws" 1
sudo update-alternatives --set java /usr/local/java/jdk1.7.0_80/bin/java
sudo update-alternatives --set javac /usr/local/java/jdk1.7.0_80/bin/javac
sudo update-alternatives --set javaws /usr/local/java/jdk1.7.0_80/bin/javaws

java -version
```

## Add the Juno Application

```console
sudo mkdir /root/.juno
```

Add or create a /root/.juno/[config.xml](config.xml)
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
