#!/bin/bash

EXEC_OK="0";
EXEC_ERR="1";

# @param cmd
# @param [ref-status] — execution result status, `$EXEC_OK` — success, else failed
execute() {
	local __ok=1;
	local __res;

	echo -n $(logInfo "- Execute \`$1\` .. ");

	if [[ ${#@} == 1 ]]; then
		__res=$(eval "$1 2>&1");
		__ok="$?";
	else
		__res=$(eval "$1 2>&1");
		__ok="$?";
		assignVar $2 $__ok;
	fi

	logInfo $(executeStatus $__ok);
	if [ $__ok -eq 0 ]; then
		logVerbose " ∟ $__res";
	else
		logErr " ∟ $__res";
	fi
}

# @param code
executeStatus() {
	if [ $1 -eq 0 ]; then
		echo $(colorize $COLOR_DONE "OK $(emojiStatus ok)");
	else
		echo $(colorize $COLOR_ERR "FAILED $(emojiStatus err)");
	fi
}

# @param cond — $Y/$EXEC_OK or $N
# @param cmd
# @param [ref-status] — execution result status, `$EXEC_OK` — success, else failed
executeIf() {
	if [[ $1 == $Y || $1 == $EXEC_OK ]]; then
		execute "$2" $3;
	else
		logVerbose "- Execute: \`$2\` .. SKIPPED";
	fi
}

# @param cond — $Y/$EXEC_OK or $N
# @param cmd
executeIfNot() {
	local __s=$1;
	if [[ $__s == $Y || $__s == $EXEC_OK ]]; then __ss=$N; else __s=$Y; fi
	executeIf $__s "$2" $3;
}