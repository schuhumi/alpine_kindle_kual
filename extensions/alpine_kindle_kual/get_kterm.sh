#!/bin/sh

TMP_DOWNLOAD="/tmp/kterm-kindle.zip"
FOLDER_EXTENSIONS="/mnt/us/extensions/"

KTERM_URL="$(curl -s https://api.github.com/repos/bfabiszewski/kterm/releases/latest \
  | grep browser_download_url \
  | grep kterm \
  | grep -v .zip.sig \
  | head -1 \
  | cut -d '"' -f 4)"

echo "Downloading kterm from $KTERM_URL"
if curl -L $KTERM_URL --output $TMP_DOWNLOAD ; then
	# success
	echo "Extracting to $FOLDER_EXTENSIONS"
	unzip -q -o $TMP_DOWNLOAD -d $FOLDER_EXTENSIONS
	rm $TMP_DOWNLOAD
	echo "kterm installed"
else
	# failed
	echo "Failed to download kterm from $KTERM_URL"
fi;
echo "DONE."
