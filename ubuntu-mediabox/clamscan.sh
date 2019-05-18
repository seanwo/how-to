#!/bin/bash
LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').txt";
EMAIL_MSG="Please see the log file attached.";
EMAIL_FROM="email@gmail.com";
EMAIL_TO="email@gmail.com";
EXCLUDE_DIRS="/sys/|/mnt/|/media/|/var/sftp/|/var/samba/";

echo "Starting a scan of $HOSTNAME.";

clamscan --exclude-dir="$EXCLUDE_DIRS" -r -i / >> "$LOGFILE";

MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);

if [ "$MALWARE" -ne "0" ];then
echo "$EMAIL_MSG" | mail -A "$LOGFILE" -s "Malware Found on $HOSTNAME" -aFrom:"$EMAIL_FROM" "$EMAIL_TO";
fi 

exit 0
