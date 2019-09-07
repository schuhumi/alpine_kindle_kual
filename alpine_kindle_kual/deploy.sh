#!/bin/bash
cd /mnt/us/extensions/alpine_kindle_kual
echo "*** Deploying / Updating Alpine Linux ***"

ALPINE_BASE_FOLDER="/mnt/us"

deploy_alpine()
{
	echo "Deploying Alpine.."
	echo "Downloading from GitHub"
	lipc-set-prop com.lab126.powerd preventScreenSaver 1

	ALPINE_URL="$(curl -s https://api.github.com/repos/schuhumi/alpine_kindle/releases/latest \
	  | grep browser_download_url \
	  | grep alpine \
	  | head -1 \
	  | cut -d '"' -f 4)"

	echo "Downloading Alpine Linux from $ALPINE_URL"
	if ! curl -L $ALPINE_URL --output /mnt/us/alpine.zip ; then
		# failed
		echo "Failed to download Alpine Linux from $ALPINE_URL"
		sh press_any_key.sh
		lipc-set-prop com.lab126.powerd preventScreenSaver 0
		exit
	fi;

	echo "Checking Storage space"
	B_REQUIRED="$(unzip -l /mnt/us/alpine.zip | tail -1 | cut -d' ' -f1)"
	KB_REQUIRED="$((B_REQUIRED/1024))"
	KB_FREE="$(df -k /mnt/us | awk '{print $4}' | tail -n -1)"
	echo "Required: $KB_REQUIRED kb"
	echo "Free: $KB_FREE kb"
	PERCENTAGE_TO_BE_USED="$(($KB_REQUIRED*100/$KB_FREE))"
	if [ "$PERCENTAGE_TO_BE_USED" -gt "99" ] ; then
		echo "Error: Not enough free storage space!"
		sh press_any_key.sh
		lipc-set-prop com.lab126.powerd preventScreenSaver 0
		exit
	else
		echo "Sufficient amount of free storage space available, will use $PERCENTAGE_TO_BE_USED% of that."
	fi

	echo "Extracting to /mnt/us"
	echo "This can take a while, please be patient..."
	sh unzip_progress.sh &
	unzip -o /mnt/us/alpine.zip -d /mnt/us

	echo "Copying service \"alpine\" into system"
	while [ ! -f /etc/upstart/alpine.conf ] ; do
		mntroot rw
		sleep 1
		cp /mnt/us/alpine.conf /etc/upstart/alpine.conf
		mntroot r
	done

	echo "Install is done!"
	sh press_any_key.sh
	lipc-set-prop com.lab126.powerd preventScreenSaver 0
	exit
}


if [ -f /mnt/us/alpine.ext3 ] ; then
	echo "Error: alpine.ext already exists. If you want to update Alpine Linux to the latest release for Kindle, you need to delete it first. ATTENTION! This will delete all data inside Alpine!"
	echo "Press any key to go back to the menu where you have the option to delete."
	sh press_any_key.sh
exit
else
	deploy_alpine
fi

