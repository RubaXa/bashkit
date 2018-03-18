#!/bin/bash
# @desc Color and style in your bash scripts.

COLOR_CLR=$(tput sgr0);
COLOR_RESET=$(tput sgr0);

COLOR_TXT=$(tput sgr0);
COLOR_ERR=$(tput setaf 1);
COLOR_DONE=$(tput setaf 2);
COLOR_INFO=$(tput setaf 4);
COLOR_WARN=$(tput setaf 5);
COLOR_VERBOSE=$(tput setaf 3);
COLOR_VAR=$(tput setaf 6);

# @param color
# @param ...text
colorize() {
	echo "$1$2$COLOR_RESET"
}

# @param ...text
colorRemove() {
	if [[ $GNU_SED == $Y ]]; then
		echo $@ | gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g";
	else
		echo $@ | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g";
	fi
}