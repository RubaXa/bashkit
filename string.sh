#!/bin/bash

# @param regex
# @param value
stringGetMatch() {
	if [[ "${@:2}" =~ $1 ]]; then
		echo ${BASH_REMATCH[1]};
	fi
}

# @param value
stringTrim() {
   local trimmed="$@"

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

# @param value
stringLength() {
    local len=0;
	for a in $@; do
		v=$(colorRemove $a);
		len=$((len + ${#v}));
	done;
    echo $len
}

# @param sep
# @param text
stringCutAfter() {
    local val="${@:2}";
    echo -e "${val%$1*}";
}

# @param sep
# @param text
stringCutBefore() {
    local val="${@:2}";
    echo -e "${val##*$1}";
}