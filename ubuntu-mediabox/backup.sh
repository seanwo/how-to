#!/bin/bash

# Export some ENV variables so you don't have to type anything
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export PASSPHRASE=""

# Your GPG key
GPG_KEY=

# The S3 destination followed by bucket name
DEST="s3://s3.amazonaws.com//BUCKETNAME/"

LOGFILE="/var/log/duplicity/backup.log"
DAILYLOGFILE="/var/log/duplicity/backup.daily.log"
HOST=`hostname`
DATE=`date +%Y-%m-%d`
MAILADDR="email@gmail.com"
TODAY=$(date +%d%m%Y)
OLDER_THAN="1Y"
FULL_OLDER_THAN="6M"
SOURCE=/

is_running=$(ps -ef | grep duplicity  | grep python | wc -l)

if [ ! -d /var/log/duplicity ];then
    mkdir -p /var/log/duplicity
fi

if [ $is_running -eq 0 ]; then

    cat /dev/null > ${DAILYLOGFILE}

    duplicity \
    	--full-if-older-than ${FULL_OLDER_THAN} \
        --s3-use-ia \
        --encrypt-key=${GPG_KEY} \
        --sign-key=${GPG_KEY} \
        --include=/mnt/media/Pictures \
        --include=/mnt/media/Music \
        --exclude=/** \
        ${SOURCE} ${DEST} >> ${DAILYLOGFILE} 2>&1

    duplicity remove-older-than ${OLDER_THAN} ${DEST} >> ${DAILYLOGFILE} 2>&1

    cat "$DAILYLOGFILE" | mail -s "Duplicity Backup Log for $HOST - $DATE" $MAILADDR

    cat "$DAILYLOGFILE" >> $LOGFILE

fi

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset PASSPHRASE
