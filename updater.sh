#!/bin/bash

bashkitUpdater() {
	logVerbose "[bashkit] Current version: $BASHKIT_VERSION"

	raw=`curl -s https://raw.githubusercontent.com/RubaXa/bashkit/master/all.sh`
	ver=$(stringGetMatch 'BASHKIT_VERSION="([^"]+)' $raw)
	logVerbose "[bashkit] Remote version: $ver"

	if [[ $BASHKIT_VERSION != $ver ]]; then
		logWarn "[bashkit] Switch to new version: $ver"
	fi
}

bashkitUpdater;