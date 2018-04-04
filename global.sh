#!/bin/bash

Y="Y"
N="N"
GNU_SED=$N

SECOND=$((1))
HOUR=$(($SECOND * 60));

ARGS=($@);

# @param val
# @peram defVal
default() {
	if [[ $1 == "" ]]; then
		echo ${@:2};
	else
		echo $1;
	fi
}

# @param val
# @param errMsg
required() {
	if [[ $1 == "" ]]; then
		logErr "$2" $(emojiStatus err);
		exit 1;
	else
		echo "$1";
	fi
}

# @param ref
# @param val
assignVar() {
	eval $1=$2;
}

# @param name
getArg() {
	for argName in ${ARGS[@]}; do
		if [[ "--$1" == "$argName" ]]; then
			echo $Y;
		fi
	done
}

# @param pattern
# @param forSED
RE() {
	local re="$1"

	if [[ "$2" == "$Y" ]]; then
		re=`echo $re | sed 's/\\\d\\+/[0-9][0-9]*/g'`;
	fi

	echo "$re" | sed 's/\d/[0-9]/g';
}