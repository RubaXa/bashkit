#!/bin/bash

RISK_FLAGS="";

# @param [branch] — create risk for git-branch
riskCreate() {
	branch=$(default "$1" "$GIT_BRANCH");
	logInfo "- Create risk for git-branch: $branch (risk flags: $(default "${RISK_FLAGS}" '[[empty]]'))";
	gitFetchAll;
	gitSwitchBranch $branch;
	gitPull;
	risk-deploy-create $RISK_FLAGS -b $branch;
}

# @param name — tarball name
# @param branch — risk branch
riskPush() {
	name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	branch=$(required "$2" "[riskPush] Risk-branch must be defined (second argument)");

	logInfo "- Risk push: $name -> $branch";
	risk-deploy-push $RISK_FLAGS --push-to-branch $branch --push-filename $name;
}

# @param name — tarball name
# @param branch — risk branch
riskSwitch() {
	name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	branch=$(required "$2" "[riskPush] Risk branch must be defined (second argument)");

	logInfo "- Risk switch: $name -> $branch";
	risk-deploy-switch --branch $branch --switch-to-folder $name;
}

# @param name — tarball name
riskAlpha() {
	name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	riskPush "$name" "alphatest"
	riskSwitch "$name" "alphatest"
}

# @param name — tarball name
# @param [branch=trb] — risk branch
riskRemove() {
	name="$1"
	branch=$(default "$2" "trb");

	echo -n $(logInfo "- Risk remove "$name" ($branch) ..");
	`risk-deploy-clear --branch $branch --clear-file $name >/dev/null 2>\&`;
	echo "" $(executeStatus $?);
}

# @param [branch] — risk branch
riskAutoRemove() {
	target="$1"
	IFS=$'\n';
	list=`risk-deploy-show | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"`;
	for line in $list; do
		if [[ "$line" =~ .\[[0-9]+\].(.+) ]]; then
			branch="${BASH_REMATCH[1]}"
			name="";
		else
			if [[ "$branch" != "" ]]; then
				if [[ $target != "" && $target != $branch ]]; then
					continue
				fi

				if [[ "$name" != "" ]]; then
					riskRemove $name $branch;
				fi

				if [[ "$line" =~ (.).\[.{3,}\].(.+) ]]; then
					if [[ "${BASH_REMATCH[1]}" != "*" ]]; then
						name="${BASH_REMATCH[2]}";
					fi
				fi
			fi
		fi
	done
}

riskExec() {
	case "$1" in
		risk-create)      riskCreate $2; ;;
		risk-push)        riskPush $2 $3; ;;
		risk-switch)      riskSwitch $2 $3; ;;
		risk-alpha)       riskAlpha $2; ;;
		risk-show)        risk-deploy-show; ;;
		risk-remove)      riskRemove $2 $3; ;;
		risk-auto-remove) riskAutoRemove $2; ;;
	esac
}