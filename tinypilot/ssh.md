## Setup SSH

source: https://www.geekyhacker.com/2021/02/15/configure-ssh-key-based-authentication-on-raspberry-pi/ 

This will setup your Raspberry Pi so that you can only SSH into it using a private/public keypair.  

Generate an RSA keypair (id_rsa_tinypilot@tinypilot & id_rsa_tinypilot@tinypilot.pub) on the client

```console
ssh-keygen -C "tinypilot@tinypilot"
```

Copy the public key to the device:  
```console
ssh-copy-id -i ~/.ssh/id_rsa_tinypilot@tinypilot.pub tinypilot@tinypilot
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
ssh -i ~./ssh/id_rsa_tinypilot@tinypilot tinypilot@tinypilot
```
