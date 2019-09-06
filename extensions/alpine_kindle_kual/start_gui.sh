#!/bin/sh

if [ -f /mnt/us/alpine.sh ] && [ -f /etc/upstart/alpine.conf ] && [ -f /mnt/us/alpine.ext3 ] ; then
	start alpine
else
	fbink -pmh -y -5 "Error: Required files missing. Deploy Alpine first!"
fi
