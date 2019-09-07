#!/bin/sh

BYTES_TOTAL="$(unzip -l /mnt/us/alpine.zip | tail -1 | cut -d' ' -f1)"
KBYTES_TOTAL="$((BYTES_TOTAL/1024))"
LIST_OF_FILES="$(unzip -l /mnt/us/alpine.zip | rev | cut -d' ' -f1 | rev | tail -n +4 | tac | tail -n +3)"
PROGRESS="0"
BYTES_EXTRACTED="0"
while [ "$PROGRESS" -lt "99" ] ; do
	KBYTES_EXTRACTED="$(cd /mnt/us && du -k -c alpine.ext3 alpine.sh alpine.conf | grep total | tail -1 | cut -d$'\t' -f1)"
	PROGRESS="$(($KBYTES_EXTRACTED*100/KBYTES_TOTAL))"
	echo "Extracted $KBYTES_EXTRACTED of $KBYTES_TOTAL kb.. ($PROGRESS%)"
	sleep 10
done
