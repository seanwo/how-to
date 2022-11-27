## Setup Duplicati

source: https://duplicati.readthedocs.io/en/latest/  

AWS Console:

S3>Buckets>Create bucket
* Bucket name: pinas-duplicati
* AWS Region: us-east-2
* Object Ownershi;: ACL disabled
* Block all public access: :white_check_mark:
* Bucket Versioning: Disabled
* Tags:
* Server-side encyption: Disabled
* Object Lock: Disabled

IAM>Policy>Create policy
* Name: duplicati-backup
* JSON
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::pinas-duplicati",
                "arn:aws:s3:::pinas-duplicati/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetUser"
            ],
            "Resource": [
                "arn:aws:iam::000000000000:user/duplicati-backup"
            ]
        }
    ]
}
```
_where 000000000000 is your AWS Account ID_

IAM>Users>Add
* User name: duplicati-backup
* Select AWS credential type: Access key - Programmatic access
* Set permission: duplicati-backup

_store off the users AWS ID and AWS KEY for programmatic access below_

Duplicati GUI:

First run setup: No, my machine has only a single account

Settings
* Password: ```[strongpassword]```

Add backup
* Add a new backup: Configure a new backup

General backup settings
* Name: pinas
* Description:
* Encryption: AES-256 encryption, built in
* Passphrase: ```[strongpassphrase]```
* Repeatpassphrase: ```[strongpassphrase]```

Backup destination
* Storage Type: S3 compatible
* Use SSL: :white_check_mark:
* Bucket name: ```pinas-duplicati```
* Bucket create region: us-east-2
* Folder path:
* AWS Access ID: ```[AWSACCESSID]```
* AWS Access key: ```[AWSACCESSKEY]```
* Client library to use: Amazon AWS SDK
* Test connection: Success (Connection worked!)

Source data
* Show hidden folders: :x:
* /music/: :white_check_mark:
* /pictures/: :white_check_mark:
* Filters: none
* Exclude: Hidden files: :white_check_mark:
* Exclude: System files: :white_check_mark:
* Exclude: Temporary files: :white_check_mark:
* Files larger than: 

Schedule
* Automatically run backups: :white_check_mark:
* Next time: 3:00 AM, Tommorrow
* Run again every: 1 Days
* Allowed days: Mon: :white_check_mark:
* Allowed days: Tue: :white_check_mark:
* Allowed days: Wed: :white_check_mark:
* Allowed days: Thu: :white_check_mark:
* Allowed days: Fri: :white_check_mark:
* Allowed days: Sat: :white_check_mark:
* Allowed days: Sun: :white_check_mark:

General options
* Remote volume size: 500 MByte
* Backup retention: Smark backup retension

Advanced options
* Add advanced option: 
