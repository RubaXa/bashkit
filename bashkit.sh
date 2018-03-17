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
		cd $BASHKIT_DIR;
		git pull
		cd -;
		logWarn "[bashkit] Try again"
		exit 1
	fi
}

bashkit;

# 'sed -r' support
`echo "foo" | sed -r 's/foo/bar/' >/dev/null 2>&1`;

if [ -x "$(command -v gsed)" ]; then
	logVerbose "[bashkit] 'sed' -> 'gsed'";
	GNU_SED=$Y;
elif [ ! $? -eq 0 ]; then
	logVerbose "[bashkit] 'sed -r' not supported"
	echo -n $(logVerbose "[bashkit] Try 'brew install gnu-sed'..");

	`brew install gnu-sed >/dev/null 2>&1`;
	logVerbose "" $(executeStatus $?);

	if [ $? -eq 0 ]; then
		GNU_SED=$Y;
	fi
fi

# VERSION
if [[ "$(getArg version)" == $Y ]]; then
	logDone "[bashkit] VERSION: $newVer $(emojiStatus done)"
	exit 0;
fi
