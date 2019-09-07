#!/bin/bash

TMP_DOWNLOAD="/tmp/alpine_kindle_kual.zip"
FOLDER_EXTENSIONS="/mnt/us/extensions/"

press_any_key()
{
	echo "Press any key to continue"
	while [ true ] ; do
		read -t 3 -n 1
		if [ $? = 0 ] ; then
			exit
		fi
	done
}

DOWNLOAD_URL="$(curl -s https://api.github.com/repos/schuhumi/alpine_kindle_kual/releases/latest \
  | grep browser_download_url \
  | grep alpine_kindle_kual.zip \
  | grep -v .zip.sig \
  | head -1 \
  | cut -d '"' -f 4)"

echo "Downloading Alpine Kindle KUAL Launcher from $DOWNLOAD_URL"
if curl -L $DOWNLOAD_URL --output $TMP_DOWNLOAD ; then
	# success
	echo "Deleting current install of Alpine Kindle KUAL Launcher"
	rm -r "$FOLDER_EXTENSIONS/alpine_kindle_kual"
	echo "Extracting to $FOLDER_EXTENSIONS"
	unzip -q -o $TMP_DOWNLOAD -d $FOLDER_EXTENSIONS
	rm $TMP_DOWNLOAD
	echo "Alpine Kindle KUAL Launcher installed"
	press_any_key
else
	# failed
	echo "Failed to download Alpine Kindle KUAL Launcher from $DOWNLOAD_URL"
	press_any_key
fi;

