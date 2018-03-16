#!/bin/bash

execute() {
	echo -n $(logInfo "- Execute \`$@\` ..")
	res=`$@`

	if [ $? -eq 0 ]; then
		echo "" $(logInfo "OK" $(emojiStatus ok))
	else
		echo "" $(logErr "FAILED" $(emojiStatus err))
	fi

	logVerbose $res
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