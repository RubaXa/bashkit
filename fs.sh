#!/bin/bash

# @param path
# @param [depth=1]
fsGetFiles() {
	local path=$(default $1 ".");
	local depth=$(default $2 1);
	find $path -maxdepth $depth -type f;
}

# @param file
fsReadFile() {
	local __IFS=$IFS;
	IFS=;
	cat $1;
	IFS=$__IFS;
}

# @param file
# @param content
fsWriteFile() {
	echo -e "${@:2}" > $1;
}

# @param file
# @param pattern
# @param value
fsReplaceInFile() {
	sed -i.bak "s/$(RE "$2" $Y)/$3/g" "$1";
	rm "$1.bak";
}

# @param path
# @param pattern
# @param value
fsReplaceInFiles() {
	logVerbose "- Replace in $1: s/$2/g -> $3";
	for f in $(fsGetFiles "$1"); do
		logVerbose " - $f"
		fsReplaceInFile "$f" "$2" "$3";
	done
}

# @param file
fsFileExists() {
	if [ -f $1 ]; then
		echo $Y;
	else
		echo $N;
	fi
}

# @param file
fsReadFileIfExists() {
	if [[ $(fsFileExists $1) == $Y ]]; then
		fsReadFile $1;
	fi
}