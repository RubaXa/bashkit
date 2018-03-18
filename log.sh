#!/bin/bash

LOG_LEVEL_ERR=$((1<<1));
LOG_LEVEL_DONE=$((1<<2));
LOG_LEVEL_WARN=$((1<<3));
LOG_LEVEL_INFO=$((1<<4));
LOG_LEVEL_VERBOSE=$((1<<5));
LOG_LEVEL=$(($LOG_LEVEL_ERR | $LOG_LEVEL_DONE | $LOG_LEVEL_WARN | $LOG_LEVEL_INFO));

if [[ $(getArg verbose) == $Y ]]; then
	LOG_LEVEL=$(($LOG_LEVEL | $LOG_LEVEL_VERBOSE));
fi

# @param level — msg, ok, done, info, warn, err, verbose
# @param ...msg
log() {
	color=$COLOR_TXT;
	level=$LOG_LEVEL;

	case "$1" in
		err)
			color=$COLOR_ERR;
			level=$LOG_LEVEL_ERR;
		;;

		done | ok)
			color=$COLOR_DONE;
			level=$LOG_LEVEL_DONE;
		;;

		warn)
			color=$COLOR_WARN
			level=$LOG_LEVEL_WARN;
		;;

		info)
			color=$COLOR_INFO;
			level=$LOG_LEVEL_INFO;
		;;

		verbose)
			color=$COLOR_VERBOSE;
			level=$LOG_LEVEL_VERBOSE;
		;;
	esac

	if (($LOG_LEVEL & $level)); then
		echo $(colorize $color "${@:2}");
	fi
}

# @param ...msg
logMsg() {
	log "msg" "$(echo $@)";
}

# @param ...msg
logErr() {
	log "err" "$(echo $@)";
}

# @param ...msg
logDone() {
	log "done" "$(echo $@)";
}

# @param ...msg
logWarn() {
	log "warn" "$(echo $@)";
}

# @param ...msg
logInfo() {
	log "info" "$(echo $@)";
}

# @param ...msg
logVerbose() {
	log "verbose" "$(echo $@)";
}

# @param ...msg
hrLine() {
	local len=$(stringLength $@);
	echo "$@";
	for ((i=0; i<$len; i++)); do echo -n "-"; done
	echo "";
}