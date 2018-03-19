#!/bin/bash

# @param text
# @param ref
inputRead() {
	echo -n "$COLOR_VAR$1 $COLOR_WARN";
	read $3 $2;
	echo -n $COLOR_CLR;
}

# @param text
# @param ref
inputReadSecure() {
	inputRead $1 $2 -s;
}

# @param text
# @param ref
inputReadChar() {
	local chr;
	inputRead "$1" chr -n1;
	assignVar $2 $chr;
	_inputReadCharFix $chr
}

# @param text
# @param ref
# @param [def=$N]
# @param [attempts=2]
inputReadYesNo() {
	local def=$(default $3 $N);
	local chr;
	local postfix="(yes/No)";
	local attempt=0;
	local maxAttempts=$(default $4 2);

	if [[ $def == "y" || $def == "Y" ]]; then
		def=$Y;
		postfix="(Yes/no)";
	fi

	while (( $attempt < $maxAttempts )) ; do
		attempt=$(( $attempt + 1 ));
		inputRead "$1 $postfix:" chr -n1;
		_inputReadCharFix $chr

		if [[ $chr == "" ]]; then
			chr=$def;
			break;
		elif [[ $chr == "y" || $chr == "Y" ]]; then
			chr=$Y;
			break;
		elif [[ $chr == "n" || $chr == "N" ]]; then
			chr=$N;
			break;
		else
			chr=$N;
			if [[ (( $attempt < $maxAttempts )) ]]; then
				echo $(colorize $COLOR_WARN "  ∟ Oops, you must press a key 'Y' or 'N', try again.");
			fi
		fi
	done

	assignVar $2 $chr;
}

_inputReadCharFix() {
	if [[ "$1" != "" ]]; then
		echo "";
	fi
}

inputReadKey() {
	local key;
	read -r -sn1 key

	case $key in
		A) echo "UP" ;;
		B) echo "DOWN" ;;
		C) echo "RIGHT" ;;
		D) echo "LEFT" ;;
		*)
			if [[ $key == "" ]]; then
				echo "ENTER";
			else
				echo "$key";
			fi
		;;
	esac

}

# @param text
# @param ref — will contains a selected index
# @param ...items
inputSelect() {
	local __sel=0;
	local __items=${@:3};

	echo -ne $(colorize $COLOR_VAR "$1 (choose one):");

	while : ; do
		local __idx=0;
		local __list="";
		local __ret=$N;

		for __item in $__items; do
			if (( $__sel == $__idx )); then
				__list="$__list\n$COLOR_DONE > ";
			else
				__list="$__list\n   ";
			fi

			__list="${__list}${__item}$COLOR_CLR";
			__idx=$(($__idx + 1));
		done

		echo -e "$__list";

		case $(inputReadKey) in
			UP) __sel=$(($__sel - 1)) ;;
			DOWN) __sel=$(($__sel + 1)) ;;
			ENTER) __ret=$Y ;;
		esac

		if (( $__sel < 0 )); then
			__sel=$(($__idx - 1));
		elif (( $__sel == $__idx )); then
			__sel=0;
		fi

		if [[ $__ret == $Y ]]; then
			assignVar $2 $__sel;
			break;
		else
			tput cuu $(($__idx + 1));
		fi
	done
}