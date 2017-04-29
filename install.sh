#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

FILES=( \
	vimrc \
	tmux.conf \
	)

# force overwrites any existing file. Skip leaves existing files unchanged
MODES=(force skip)
MODE=0

function print_help {
	MODES_STR=${MODES[0]}
	for MODE in ${MODES[@]:1}; do
		MODES_STR+="|${MODE}"
	done
	echo "${ME} [${MODES_STR}]"
	exit -1
	}

function load_parameters {
	if [[ $# -gt 1 ]]; then
		print_help
	fi
	if [[ $# -eq 1 ]]; then
		if [[ $1 == "force" ]]; then
			MODE=1
		elif [[ $1 == "skip" ]]; then
			MODE=1
		else
			print_help
		fi
	fi
	}

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
	if ! [[ -e "$FULL_NAME" ]]; then
		echo "Source file doesn't exist. Skipping"
		exit
	fi
	if [[ -e "${DOT_FILE}" ]]; then
		# Check if forcing overwrite
		if [[ ${MODE} -eq 1 ]]; then
			echo "Removing file '$DOT_FILE'"
			rm "$DOT_FILE"
		else
			echo "${DOT_FILE} exists. Skipping"
			return
		fi
	fi

	ln -s ${FULL_NAME} ${DOT_FILE}
	}


load_parameters $@

for FILE in "${FILES[@]}"; do
	install_link $DIR $FILE
done

exit 0

