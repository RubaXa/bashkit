#!/bin/bash

execute() {
	echo -n $(logInfo "- Execute \`$@\` ..")
	res=`$@ >/dev/null 2>&1`;
	echo "" $(executeStatus $?)
	logVerbose $res
}

executeStatus() {
	if [ $1 -eq 0 ]; then
		echo $(logInfo "OK" $(emojiStatus ok))
	else
		echo $(logErr "FAILED" $(emojiStatus err))
	fi
}

executeIf() {
	cmd=${@:2};

	if [[ $1 == $Y ]]; then
		execute $cmd
	else
		logVerbose "- Execute: \`$cmd\` .. SKIPPED"
	fi
}

executeIfNot() {
	s=$1;
	if [[ $s == $Y ]]; then s=$N; else s=$Y;fi
	executeIf $s "${@:2}"
}