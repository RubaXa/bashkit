#!/bin/bash

# @param value
# @param ...list — for example `arrayIncludes "y" "x" "y"` `${list[@]}`, or `arrayIncludes $val ${list[@]}``
arrayIncludes() {
	local __exists=$N;
	for v in ${@:2}; do
		if [[ "$1" == "$v" ]]; then
			__exists=$Y;
			break;
		fi
	done
	echo $__exists;
}
