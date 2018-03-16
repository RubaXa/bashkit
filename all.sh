#!/bin/bash

BASHKIT_DIR="$HOME/.bashkit";
BASHKIT_VERSION="0.3.0"

source "$BASHKIT_DIR/global.sh";
source "$BASHKIT_DIR/string.sh";
source "$BASHKIT_DIR/time.sh";
source "$BASHKIT_DIR/emoji.sh";
source "$BASHKIT_DIR/colors.sh";
source "$BASHKIT_DIR/log.sh";
source "$BASHKIT_DIR/exec.sh";
source "$BASHKIT_DIR/git.sh";
source "$BASHKIT_DIR/risk.sh";

#LOG_LEVEL=$(($LOG_LEVEL | $LOG_LEVEL_VERBOSE));

# AutoUpdater
source "$BASHKIT_DIR/updater.sh";
