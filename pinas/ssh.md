## Setup SSH Keypair Only Access

Generate an RSA keypair (id_rsa_admin@pinas & id_rsa_admin@pinas.pub) on the client:
```console
ssh-keygen -t rsa -C "admin@pinas"
```

In the OMV6 GUI:  

User Management>Users>```admin```>Edit
* SSH public keys: ```[contents of id_rsa_admin@pinas.pub]```


Confirm that you can ssh with the rsa private key and not passwords.  To login with the rsa private key use this command from the client:  
```console
ssh -i ~./ssh/id_rsa_admin@pinas admin@pinas
```

Now turn off root and password based ssh logins.

In the OMV6 GUI:  

Services>SSH
* Enabled: :white_check_mark:
* Port: 22
* Permit root login: :x:
* Password authentication: :x:
* Public key authentication: :white_check_mark:
* TCP forwarding: :x:
* Compression: :x:
* Extra options:
