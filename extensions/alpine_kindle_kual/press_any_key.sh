#!/bin/sh
echo "Press any key to continue"
while [ true ] ; do
	read -t 3 -n 1
	if [ $? = 0 ] ; then
		exit
	fi
done
