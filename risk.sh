#!/bin/bash

RISK_FLAGS="";

# @param [branch] — create risk for git-branch
# @param [deploy] — push & switch created tarball to risk branch
riskCreate() {
	local branch=$(default "$1" "$GIT_BRANCH");
	local deploy=$(default "$2" "$N");

	logInfo "- Create risk for git-branch: $branch (risk flags: $(default "${RISK_FLAGS}" '[[empty]]'))";
	gitFetchAll;
	gitSwitchBranch $branch;
	gitPull;
	risk-deploy-create $RISK_FLAGS -b $branch;

	if [[ "$deploy" != $N ]]; then
		local list=($(riskGetList "trb"));
		local tarball=${list[${#list[@]}-1]};

		logInfo "Push & Switch: $tarball -> $deploy";
		riskPush $tarball $deploy;
		riskSwitch $tarball $deploy;
	fi
}

# @param name — tarball name
# @param branch — risk branch
riskPush() {
	local name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	local branch=$(required "$2" "[riskPush] Risk-branch must be defined (second argument)");

	logInfo "- Risk push: $name -> $branch";
	risk-deploy-push $RISK_FLAGS --push-to-branch $branch --push-filename $name;
}

# @param name — tarball name
# @param branch — risk branch
riskSwitch() {
	local name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	local branch=$(required "$2" "[riskPush] Risk branch must be defined (second argument)");

	logInfo "- Risk switch: $name -> $branch";
	risk-deploy-switch --branch $branch --switch-to-folder $name;
}

# @param name — tarball name
riskAlpha() {
	local name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	riskPush "$name" "alphatest"
	riskSwitch "$name" "alphatest"
}

# @param name — tarball name
# @param [branch=trb] — risk branch
riskRemove() {
	local name="$1"
	local branch=$(default "$2" "trb");

	echo -n $(logInfo "- Risk remove "$name" ($branch) ..");
	`risk-deploy-clear --branch $branch --clear-file $name >/dev/null 2>\&`;
	echo "" $(executeStatus $?);
}

# @param [branch] — risk branch
riskAutoRemove() {
	local target="$1";
	local branch="";
	local name="";
	local __IFS=$IFS;

	IFS=$'\n';
	list=`risk-deploy-show | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"`;

	for line in $list; do
		logVerbose "[risk-auto-remove] Try parse line: '${line}'";

		if [[ "$line" =~ .\[[0-9]+\].(.+) ]]; then
			branch="${BASH_REMATCH[1]}"
			name="";
			logVerbose "[risk-auto-remove] Detected branch: '${branch}'";
		else
			if [[ "$branch" != "" ]]; then
				if [[ $target != "" && $target != $branch ]]; then
					continue
				fi

				if [[ "$name" != "" ]]; then
					riskRemove $name $branch;
				fi

				if [[ "$line" =~ (.).\[.{3,}\].(.+) ]]; then
					logVerbose "[risk-auto-remove] Try parse trb: '${line}'";
					if [[ "${BASH_REMATCH[1]}" != "*" ]]; then
						name="${BASH_REMATCH[2]}";
						logVerbose "[risk-auto-remove] trb name parsed: '${name}'";
					fi
				fi
			fi
		fi
	done

	IFS=$__IFS;
}

# @param [branch] — risk branch
riskGetList() {
	local target=$(default "$1" "trb");
	local branch="";
	local list=();

	IFS=$'\n';
	local riskShow=`risk-deploy-show | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"`;

	for line in $riskShow; do
		if [[ "$line" =~ .\[[0-9]+\].(.+) ]]; then
			branch="${BASH_REMATCH[1]}"
		else
			if [[ "$branch" == "$target" ]]; then
				if [[ "$line" =~ (.).\[.{3,}\].(.+) ]]; then
					list+=("${BASH_REMATCH[2]}");
				fi
			fi
		fi
	done

	IFS=$__IFS;
	echo ${list[@]};
}

riskExec() {
	case "$1" in
		# Create risk
		risk) riskCreate $2 $3; ;;
		risk-create) riskCreate $2 $3; ;;

		# Create risk and push&switch (default "alphatest")
		+risk)
			local __branch=$(default "$3" "alphatest");

			logInfo "[$__branch] create, push & switch";
			riskCreate $2 $__branch;
			riskGetList $__branch;
			;;

		# Push to "production" (default)
		++risk)
			local __branch=$(default "$3" "production");
			local __switch;

			riskPush $2 $__branch;
			inputReadYesNo "Risk switch: $2 -> $__branch" $__switch;

			if [[ $__switch == $Y ]]; then
				riskSwitch $2 $__branch;
			fi
			;;

		# Switch on "production" (default)
		^^risk)
			local __branch=$(default "$3" "production");
			riskSwitch $2 $__branch;
			;;

		# Show risk
		risk?) risk-deploy-show; ;;
		risk-show) risk-deploy-show; ;;

		risk-list)        riskGetList $2; ;;

		risk-push)        riskPush $2 $3; ;;
		risk-push-prod)   riskPush $2 "production"; ;;

		risk-switch)      riskSwitch $2 $3; ;;
		risk-switch-prod) riskSwitch $2 "production"; ;;

		risk-remove)      riskRemove $2 $3; ;;
		risk-auto-remove) riskAutoRemove $2; ;;
	esac
}
