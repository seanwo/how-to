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
add or update the following lines:
```
PermitRootLogin no
ChallengeResponseAuthentication no
Subsystem sftp internal-sftp
AllowUsers sftpuser
Match Group sftp_users
ForceCommand internal-sftp
PasswordAuthentication no
PermitEmptyPasswords no
ChrootDirectory /var/sftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
```
```console
sudo systemctl restart ssh.service
```
Create the sftpuser and the sftp_users group:
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
On another machine generate a public/private keypair:
```console
ssh-keygen -t rsa -b 4096 -m PEM -C "sftpuser"
```
Store the private key as /Users/username/.ssh/id_rsa_sftpuser

Now setup the public key on the server:
```console
sudo su sftpuser
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
```
copy the text from /Users/username/.ssh/id_rsa_sftpuser.pub into authorized_keys and save the file.
```console
vi authorized_keys
```
```console
chmod 600 ~/.ssh/authorized_keys
exit
```
Now from the client machine you should be able to use the private key to connect:
```console
sftp -i ~/.ssh/id_rsa_sftpuser sftpuser@mediabox
```
