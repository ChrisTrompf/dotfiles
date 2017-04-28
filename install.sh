#!/bin/bash

set -x


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function create a symlink in the home folder, pointing to the passed filenme
# eg install_link "!/dotfiles " "vimcr" --> ln -s ~/dotfiles/vimrc ~/.vimrc
function install_link {
	# Get the source dir
	DIR_NAME=$1
	# Get the filename from the the full path
	FILE_NAME=$2
	FULL_NAME="$1/$2"
	# Generate a dotfile name
	DOT_FILE=~/.${FILE_NAME}
	echo "Creating symlink '$DOT_FILE' for '$FULL_NAME'"
	if ! [ -e "$FULL_NAME" ]; then
		echo "Source file doesn't exist. Skipping"
		exit
	fi
	if [ -e "${DOT_FILE}" ]; then
		if [ $# -eq 3 ] && [ $3 == "force" ]; then
			echo "Removing file '$DOT_FILE'"
			rm "$DOT_FILE"
		else
			echo "${DOT_FILE} exists. Skipping"
			exit
		fi
	fi

	ln -s ${FULL_NAME} ${DOT_FILE}
	}

FILES=( \
	vimrc \
	)

echo $FILES

for FILE in $FILES ; do
	install_link $DIR $FILE
#	echo $FILE
done

