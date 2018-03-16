#!/bin/bash

stringGetMatch() {
	if [[ "${@:2}" =~ $1 ]]; then
		echo ${BASH_REMATCH[1]};
	fi
}