#!/bin/bash

stringGetMatch() {
	if [[ "${@:2}" =~ $1 ]]; then
		echo ${BASH_REMATCH[1]};
	fi
}

stringTrim() {
   local trimmed="$1"

    # Strip leading spaces.
    while [[ $trimmed == ' '* ]]; do
       trimmed="${trimmed## }"
    done

    # Strip trailing spaces.
    while [[ $trimmed == *' ' ]]; do
        trimmed="${trimmed%% }"
    done

    echo "$trimmed"
}

stringLength() {
    local len=0;
	for a in $@; do
		v=$(colorRemove $a);
		len=$((len + ${#v}));
	done;
    echo $len
}