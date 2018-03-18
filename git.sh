#!/bin/bash

gitPull() {
	execute "git pull";
}

gitFetchAll() {
	execute "git fetch --all"
}

gitCurrentBranch() {
	stringGetMatch 'branch[[:blank:]]([a-zA-Z0-9_-]+)' $(git status >/dev/null 2>&1)
}

# @param name
gitIsCurrentBranch() {
	if [[ "$(gitCurrentBranch)" == "$1" ]]; then
		echo $Y
	else
		echo $N
	fi
}

# @param name
gitSwitchBranch() {
	branch="$1";
	needSwicth="$(gitIsCurrentBranch $branch)";
	executeIfNot $needSwicth "git checkout $branch 2>/dev/null || git checkout -b $branch origin/$branch"
}

GIT_BRANCH=$(gitCurrentBranch)