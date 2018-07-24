#!/bin/bash

gitPull() {
	execute "git pull";
}

gitFetchAll() {
	execute "git fetch --all";
}

gitCurrentBranch() {
	git rev-parse --abbrev-ref HEAD;
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
	local branch="$1";
	local needSwicth="$(gitIsCurrentBranch $branch)";
	executeIfNot $needSwicth "git checkout $branch 2>/dev/null || git checkout -b $branch origin/$branch"
}

gitHasChanges() {
	if [[ `git status --porcelain` ]]; then
		echo $Y;
	else
		echo $N;
	fi
}

GIT_BRANCH=$(gitCurrentBranch)