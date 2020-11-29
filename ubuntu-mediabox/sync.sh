#!/bin/bash
HOST=`hostname`
DATE=`date +%Y-%m-%d`
MAILADDR="email@gmail.com"
DAILYLOGFILE="/var/log/rsync/sync.daily.log"

rsync -ahPHAXx --delete /mnt/media/ /mnt/backup > ${DAILYLOGFILE} 2>&1

if [ $? -eq 0 ]
then
  echo "success!" | mail -s "Sync Log (Success) for $HOST - $DATE" $MAILADDR
else
  cat "$DAILYLOGFILE" | mail -s "Sync Log (ERROR!) for $HOST - $DATE" $MAILADDR
fi
