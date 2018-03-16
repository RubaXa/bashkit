#!/bin/bash

gitPull() {
	execute "git pull";
}

gitFetchAll() {
	execute "git fetch --all"
}

gitCurrentBranch() {
	stringGetMatch 'branch[[:blank:]]([a-zA-Z0-9_-]+)' $(git status)
}

gitIsCurrentBranch() {
	if [[ "$(gitCurrentBranch)" == "$1" ]]; then
		echo $Y
	else
		echo $N
	fi
}

gitSwitchBranch() {
	branch="$1";
	needSwicth="$(gitIsCurrentBranch $branch)";
	executeIfNot $needSwicth "git checkout $branch 2>/dev/null || git checkout -b $branch origin/$branch"
}