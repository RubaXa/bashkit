#!/bin/bash

Y="Y"
N="N"
SECOND=$((1))
HOUR=$(($SECOND * 60));

ARGS=($@);

default() {
	if [[ $1 == "" ]]; then
		echo ${@:2};
	else
		echo $1;
	fi
}

required() {
	if [[ $1 == "" ]]; then
		logErr "$2" $(emojiStatus err);
		exit 1;
	else
		echo "$1";
	fi
}

getArg() {

	for argName in ${ARGS[@]}; do
		if [[ "--$1" == "$argName" ]]; then
			echo $Y;
		fi
	done
}
