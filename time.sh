#!/bin/bash

now() {
	date +%s
}

# @param value — ex.: `2s`, `5m`, `24h` or `5d`
timeParse() {
	local __parsed=( $(stringGetMatches "([0-9]+)([smhd]+)" "$1") );
	local __time=$(( ${__parsed[1]} * 1 ));

	case "${__parsed[2]}" in
		m) __time=$(( __time * 60 )); ;;
		h) __time=$(( __time * 60 * 60 )); ;;
		d) __time=$(( __time * 60 * 60 * 24 )); ;;
	esac

	echo $__time;
}
