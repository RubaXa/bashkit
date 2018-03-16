#!/bin/bash

BASHKIT_REFRESH_TIME=$HOUR;

bashkit() {
	tmpfile="$BASHKIT_DIR/.last-update";
	time=$(now);
	newVer="";

	logVerbose "[bashkit] Current version: $BASHKIT_VERSION"

	if [ -f $tmpfile ]; then
		prevTime=`cat $tmpfile`;
		if (($time - $prevTime < $BASHKIT_REFRESH_TIME)); then
			logVerbose "[bashkit] Skip checking version"
			newVer=$BASHKIT_VERSION;
		fi
	fi

	if [[ "$newVer" == "" ]]; then
		raw=`curl -s https://raw.githubusercontent.com/RubaXa/bashkit/master/all.sh`
		newVer=$(stringGetMatch 'BASHKIT_VERSION="([^"]+)' $raw)
		echo "$time" > $tmpfile;
	fi

	logVerbose "[bashkit] Remote version: $newVer"

	if [[ $BASHKIT_VERSION != $newVer ]]; then
		logWarn "[bashkit] Switch to new version: $newVer"
		execute "cd $BASHKIT_DIR";
		execute "git pull";
		execute "cd -";
		logDone "[bashkit] Try again $(emojiStatus done)"
		exit 1
	fi

	if [[ "$(getArg version)" == $Y ]]; then
		logDone "VERSION: $newVer $(emojiStatus done)"
	fi
}

bashkit;