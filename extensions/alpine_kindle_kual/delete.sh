#!/bin/sh

ALPINE_BASE_FOLDER="/mnt/us"

while true; do
	read -p "Are you sure you want to delete Alpine Linux? This will remove the files /mnt/us/alpine.{ext3,sh,log,conf,zip} and /etc/upstart/alpine.conf (type y or n): " yn
	case $yn in
		[Yy]* ) echo "Deleting..."; break;;
		[Nn]* ) echo "Aborted."; sh press_any_key.sh; exit;;
		* ) echo "Please answer yes or no.";;
	esac
done

rm $ALPINE_BASE_FOLDER/alpine.ext3
rm $ALPINE_BASE_FOLDER/alpine.sh
rm $ALPINE_BASE_FOLDER/alpine.log
rm $ALPINE_BASE_FOLDER/alpine.conf
rm $ALPINE_BASE_FOLDER/alpine.zip
while [ -f /etc/upstart/alpine.conf ] ; do
	mntroot rw
	sleep 1
	rm /etc/upstart/alpine.conf
	mntroot r
done
echo "Deleted Alpine."
sh press_any_key.sh
