#!/bin/bash

BASHKIT_REFRESH_TIME=$HOUR;

bashkit() {
	local tmpfile="$BASHKIT_DIR/.last-update";
	local time=$(now);
	local newVer="";

	logVerbose "[bashkit] Current version: $BASHKIT_VERSION"

	if [ -f $tmpfile ]; then
		prevTime=`cat $tmpfile`;
		if (($time - $prevTime < $BASHKIT_REFRESH_TIME)); then
			logVerbose "[bashkit] Skip checking version"
			newVer=$BASHKIT_VERSION;
		fi
	fi

	if [[ "$newVer" == "" ]]; then
		local raw=`curl -s https://raw.githubusercontent.com/RubaXa/bashkit/master/all.sh`
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

	# 'sed -r' support
	`echo "foo" | sed -r 's/foo/bar/' >/dev/null 2>&1`;

	if [ -x "$(command -v gsed)" ]; then
		logVerbose "[bashkit] 'sed' -> 'gsed'";
		GNU_SED=$Y;
	elif [ ! $? -eq 0 ]; then
		logVerbose "[bashkit] 'sed -r' not supported"
		echo -n $(logVerbose "[bashkit] Try 'brew install gnu-sed'..");

		`brew install gnu-sed >/dev/null 2>&1`;
		if [ $? -eq 0 ]; then GNU_SED=$Y; fi

		logVerbose "" $(executeStatus $?);
	fi

	# VERSION
	if [[ "$(getArg version)" == $Y ]]; then
		logDone "[bashkit] VERSION: $newVer $(emojiStatus done)"
		exit 0;
	fi

	# DOCS
	if [[ "$(getArg "bashkit-docs")" == $Y ]]; then
		local doc;

		for file in $(fsGetFiles "."); do
			logVerbose "[bashkit] Parse $file";
			local lineNo=0;
			local startLine="";
			local desc="";
			local consts="";
			local args="";
			local inlineArgs="";
			local fns="";
			local tmp="";
			local _IFS=$IFS;

			while IFS='' read -r line || [[ -n "$line" ]]; do
				lineNo=$((lineNo + 1));

				# desc
				tmp=$(stringGetMatch "@desc[[:blank:]](.+)" "$line")
				if [[ $tmp != "" ]]; then
					desc="$tmp\n";
				fi

				# const
				tmp=$(stringGetMatch "^([A-Z_]+)=" "$line")
				if [[ $tmp != "" ]]; then
					consts="$consts- [\$$tmp]($file#L$lineNo)\n";
				fi

				# param
				tmp=$(stringGetMatch "@param[[:blank:]]+(.+)" "$line")
				if [[ $tmp != "" ]]; then
					if [[ $(stringTest "[[:space:]]" $tmp) == $Y ]]; then
						args="$args- $tmp\n";
					fi
					inlineArgs="$inlineArgs $(stringGetMatch "^([^[:space:]]+)" $tmp)";
					if [[ $startLine == "" ]]; then startLine=$lineNo; fi;
				fi

				# fn
				tmp=$(stringGetMatch "^([a-z][[:alpha:]]+)\(\)" "$line")
				if [[ $tmp != "" ]]; then
					fnName=$tmp;
				fi

				if [[ $startLine != "" && $line == "}" ]]; then
					fns="$fns##### [$fnName]($file#L$startLine-L$lineNo) \`${inlineArgs:1}\`\n$args\n";
					args="";
					desc="";
					startLine="";
					inlineArgs="";
				fi
			done < $file;

			IFS=$_IFS;

			if [[ $fns != "" ]]; then
				doc="$doc---\n\n### [${file:2}]($file)\n$desc\n";

				if [[ $consts == "" ]]; then
					doc="$doc\n$fns";
				else
					doc="$doc#### Constants\n$consts\n#### Functions\n\n$fns";
				fi

				fns="";
			fi
		done

		local md=$(fsReadFile README.md);
		md="$(stringCutAfter "<!--api-->" "$md")\n<!--api-->\n$doc";
		fsWriteFile "README.md" "$md";

		logFinish $EXEC_OK "Docs generated";
	fi
}

bashkit;
