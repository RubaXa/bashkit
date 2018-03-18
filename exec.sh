#!/bin/bash

# @param cmd
execute() {
	echo -n $(logInfo "- Execute \`$@\` ..")
	res=`$@ >/dev/null 2>&1`;
	echo "" $(executeStatus $?)
	logVerbose $res
}

# @param code
executeStatus() {
	if [ $1 -eq 0 ]; then
		echo $(colorize $COLOR_OK "OK " $(emojiStatus ok))
	else
		echo $(colorize $COLOR_ERR "FAILED " $(emojiStatus err))
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