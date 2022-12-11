## Install SMTP Client (Outbound Email)

source: https://www.linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu/  
source: https://docs.sendgrid.com/for-developers/sending-email/postfix  
source: https://docs.sendgrid.com/for-developers/sending-email/smtp-errors-and-troubleshooting#550-unauthenticated-senders-not-allowed  
source: https://www.cyberciti.biz/tips/howto-postfix-masquerade-change-email-mail-address.html  

Create a new gmail account. (In this example we use email@gmail.com; replace this with your new gmail address and real password).  Creating and using a sendgrid account using single sender verification will remove the security headaches associated with gmail's less secure apps and geo ip blocking as your ip changes.

```console
sudo apt install postfix
```
Note: select to set it up for internet email.

Configure postfix with your new gmail account:
```console
sudo vi /etc/postfix/sasl/sasl_passwd
```
```
[smtp.gmail.com]:587 email@gmail.com:password
```
*or if you are using sendgrid:*
```
[smtp.sendgrid.net]:587 apikey:yourSendGridApiKey
```
```console
sudo postmap /etc/postfix/sasl/sasl_passwd
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```
```console
sudo vi /etc/postfix/main.cf
```
Update the relayhost:
```
relayhost = [smtp.gmail.com]:587
```
*or if you are using sendgrid:* 
```
relayhost = [smtp.sendgrid.net]:587
```
and then add the following lines:
```
smtp_sasl_auth_enable = yes
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
smtp_tls_security_level = encrypt
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```
*also if you are using sendgrid add the following line:*
```
smtp_generic_maps = hash:/etc/postfix/generic
```
*also if you are using sendgrid create a generic map file:*
```console
sudo vi /etc/postfix/generic
```
and then add local accounts to from address map entries:
```
user@yourhostname email@gmail.com
root@yourhostname email@gmail.com
user@yourhostname.example.com email@gmail.com
root@yourhostname.example.com email@gmail.com
```
*also if you are using sendgrid apply the generic map:*
```console
sudo postmap /etc/postfix/generic
```
now complete the setup:
```console
sudo systemctl restart postfix
sudo apt install mailutils
```
Test that you can send email:
```console
echo "body" | mail -s "subject" test@email.com
```
where test@email.com is a different email account where you can confirm receipt of a test email.

