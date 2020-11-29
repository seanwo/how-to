## Install SMTP Client (Outbound Email)

source: https://www.linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu/

Create a new gmail account. (In this example we use email@gmail.com; replace this with your new gmail address and real password)

```console
sudo apt install postfix
```
Configure postfix with your new gmail account:
```console
sudo vi /etc/postfix/sasl/sasl_passwd
```
```
[smtp.gmail.com]:587 email@gmail.com:password
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
and then add the following lines:
```
# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```
```console
sudo systemctl restart postfix
sudo apt install mailutils
```
Test that you can send email:
```console
echo "body" | mail -s "subject" test@email.com
```
where test@email.com is a different email account where you can confirm receipt of a test email.

