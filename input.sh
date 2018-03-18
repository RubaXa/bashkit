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
