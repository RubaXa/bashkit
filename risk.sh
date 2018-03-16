#!/bin/bash

RISK_FLAGS="";

riskCreate() {
	branch=$(default "$1" "master");
	logInfo " - Create risk for git-branch: $branch (risk flags: $RISK_FLAGS)";
	$(gitFetchAll);
	$(gitSwitchBranch $branch);
	$(gitPull);
	risk-deploy-create $RISK_FLAGS -b $branch;
}

riskPush() {
	name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	branch=$(required "$2" "[riskPush] Risk branch must be defined (second argument)");

	$(logInfo " - Risk push: $name -> $branch");
	risk-deploy-push $RISK_FLAGS --push-to-branch $branch --push-filename $name;
}

riskSwitch() {
	name=$(required "$1" "[riskPush] tarball name must be defined (first argument)");
	branch=$(required "$2" "[riskPush] Risk branch must be defined (second argument)");

	$(logInfo " - Risk switch: $name -> $branch");
	risk-deploy-switch --branch $branch --switch-to-folder $name;
}