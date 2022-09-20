## Setup SFTP

Generate an RSA keypair (id_rsa_sftpuser@pinas & id_rsa_sftpuser@pinas.pub) on the client:
```console
ssh-keygen -t rsa -C "sftpuser@pinas"
```

OMV6 GUI:  

System>Plugins>Search>```openmediavault-sftp```>Install 

openmediavault-nut
User Management>Users>Create
* Name: sftpuser
* Email:
* Password: ```[generate a strong random password]```
* Confirm Password:
* Shell: /bin/sh
* Groups: sftp-access, users
* SSH public keys: ```[contents of id_rsa_sftpuser@pinas.pub]```
* Disallow account modification: :x:
* Comment:

Now turn off root and password based ssh logins.

In the OMV6 GUI:  

Services>sftp
* Enabled: :white_check_mark:
* Port: 222
* Password authentication: :x:
* Public key authentication: :white_check_mark:
* AllowGroups: :white_check_mark:
* Rsyslog: :white_check_mark:
* Extra options:

Confirm that you can only sftp with the rsa private key and not passwords.  To login with the rsa private key use this command from the client:  
```console
sftp -i id_rsa_sftpuser\@pinas -P 222 sftpuser@pinas
```
