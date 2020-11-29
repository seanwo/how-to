## Duplicity w/ S3 (Encrypted Cloud Backup)

source: https://easyengine.io/tutorials/backups/duplicity-amazon-s3

_This assumes you have an AWS account and know how to use it._

AWS S3: Create a new non public bucket.  
AWS IAM: Create duplicity-backup programmatic user and store off the access and secret keys.  
AWS IAM: Create duplicity-backup policy (replace BUCKET_NAME with your real bucket name):
```
{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::BUCKET_NAME",
                "arn:aws:s3:::BUCKET_NAME/*"
            ]
        }
    ]
}
```
AWS IAM: Assign duplicity-backup policy to duplicity-backup user.

```console
sudo apt install duplicity
sudo apt install python-boto
```
Build your encryption public/private key:
```console
gpg --full-generate-key
```
Use the defaults.

real name: duplicity  
email: your real email  
comment: duplicity gpg key

Set a secure passphrase.

Export your keys:
```console
gpg --export -a "duplicity" > public.key
gpg --export-secret-key -a "duplicity" > private.key
```
**Backup these keys (along with the passphrase to unlock the secret key) in a secure location such as https://www.lastpass.com.**  Then remove the .key files.

```console
sudo mkdir /var/log/duplicity
sudo chown mediauser:mediauser /var/log/duplicity
```
```console
vi ~/backup.sh
```
Use the following file and update as appropriate for your accounts and directories:

[backup.sh](backup.sh)
```console
chmod +x ~/backup.sh
```
```console
vi ~/restore.sh
```
Use the following file and update as appropriate for your accounts and directories:

todo
```console
chmod +x ~/restore.sh
```
Run daily as mediauser at 4am
```console
crontab -e
```
```
0 4 * * * /home/mediauser/backup.sh >/dev/null 2>&1
```
