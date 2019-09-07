#!/bin/sh

if [ -f /mnt/us/alpine.sh ] && [ -f /etc/upstart/alpine.conf ] && [ -f /mnt/us/alpine.ext3 ] ; then
	/mnt/us/extensions/kterm/bin/kterm -e "sh /mnt/us/alpine.sh" -k 1 -o U -s 7
else
	fbink -pmh -y -5 "Error: Required files missing. Deploy Alpine first!"
fi
