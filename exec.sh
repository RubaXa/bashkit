#!/bin/bash

EXEC_OK="0";

# @param cmd
# @param [ref-status] — execution result status, `$EXEC_OK` — success, else failed
execute() {
	local __ok=1;
	local __res;
	echo -n $(logInfo "- Execute \`$1\` .. ");

	if [[ ${#@} == 1 ]]; then
		__res=`$1 >/dev/null 2>&1`;
		__ok="$?";
	else
		__res=`$1 >/dev/null 2>&1`;
		__ok="$?";
		assignVar $2 $__ok;
	fi

	logInfo $(executeStatus $__ok);
	logVerbose $res
}

# @param code
executeStatus() {
	if [ $1 -eq 0 ]; then
		echo $(colorize $COLOR_DONE "OK $(emojiStatus ok)");
	else
		echo $(colorize $COLOR_ERR "FAILED $(emojiStatus err)");
	fi
}

# @param cond — $Y or $N
# @param cmd
executeIf() {
	cmd=${@:2};

	if [[ $1 == $Y ]]; then
		execute $cmd
	else
		logVerbose "- Execute: \`$cmd\` .. SKIPPED"
	fi
}

# @param cond — $Y or $N
# @param cmd
executeIfNot() {
	s=$1;
	if [[ $s == $Y ]]; then s=$N; else s=$Y;fi
	executeIf $s "${@:2}"
}