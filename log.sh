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
	log "msg" "$@";
}

# @param ...msg
logErr() {
	log "err" "$@";
}

# @param ...msg
logDone() {
	log "done" "$@";
}

# @param ...msg
logWarn() {
	log "warn" "$@";
}

# @param ...msg
logInfo() {
	log "info" "$@";
}

# @param ...msg
logVerbose() {
	log "verbose" "$@";
}

prevHrLineLen=0;

# @param ...msg
hrLine() {
	local len=$(stringLength $@);
	if (( $len == 0 )); then
		len=$prevHrLineLen;
	else
		prevHrLineLen=$len
		echo "$@";
	fi

	for ((i=0; i<$len; i++)); do echo -n "-"; done
	echo "";
}

# @param text
logHead() {
	hrLine $(logInfo "$@");
}

# @param [status]
# @param [done=DONE]
# @param [failed=FAILED]
logFinish() {
	local __ok=$EXEC_OK;
	local __done=$(default "$2" "DONE");
	local __failed=$(default "$3" "FAILED");

	if [[ ${#@} > 0 ]]; then __ok=$1; fi

	if [[ $__ok == $EXEC_OK ]]; then
		logDone "$__done $(emojiStatus done)";
	else
		logErr "$__failed $(emojiStatus err)";
	fi

	echo "";
}
