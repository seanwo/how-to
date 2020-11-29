#!/bin/bash
HOST=`hostname`
DATE=`date +%Y-%m-%d`
MAILADDR="email@gmail.com"
DAILYLOGFILE="/var/log/duplicity/sync.daily.log"

rsync -ahPHAXx --delete --exclude 'TimeMachine' /mnt/media/ /mnt/backup > ${DAILYLOGFILE} 2>&1

if [ $? -eq 0 ]
then
  cat "$DAILYLOGFILE" | mail -s "Sync Log (Success) for $HOST - $DATE" $MAILADDR
else
  cat "$DAILYLOGFILE" | mail -s "Sync Log (ERROR!) for $HOST - $DATE" $MAILADDR
fi
