#!/bin/bash

# @param path
# @param [depth=1]
fsGetFiles() {
	local depth=$(default $2 1);
	find $1 -maxdepth $depth -type f;
}

# @param file
fsReadFile() {
	local _IFS=$IFS;
	IFS=;
	cat $1;
	IFS=$_IFS;
}

# @param file
# @param content
fsWriteFile() {
	echo -e "${@:2}" > $1;
}