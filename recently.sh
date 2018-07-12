#!/bin/bash

# @param name
# @param period — ex: `5m`, `24h` or `7d`
# @param ...fn
recently() {
	local __name=$1;
	local __period=$2;
	local __file="$BASHKIT_DIR/.recently/$__name.$(md5hash "$DIRNAME.$FILENAME")";
	local __items=(${@:3});
	local __used=$N;
	local __usage=$(stringTrim "$(fsReadFileIfExists $__file)");
	local __len=${#__items[@]};
	local __seq=();
	local __priorty=();
	local __exists=();
	local __idx;
	local __jdx;

	callback() {
		__used=$Y
	}

	# Default priorty
	for (( __idx=0; $__idx < $__len; __idx++ )); do
		((__exists[$__idx]=0));
		((__priorty[$__idx]=0));
		((__seq[$__idx]=$__idx));
	done

	# Set priorty
	local __IFS=$IFS;
	local __line;
	local __recent=$(( $(now) - $(timeParse "$__period") ));
	local __filtered;

	IFS=$'\r\n';
	for __line in $__usage; do
		local __idx=$(stringGetMatch "([0-9]+)" $__line);
		local __time=$(stringGetMatch "[[:space:]]([0-9]+)" $__line);

		if (( $__recent <= $__time )); then
			((__priorty[$__idx]++));
			__filtered="${__filtered}$__idx $__time\\r\\n";
		fi
	done
	__usage=$__filtered;
	IFS=$__IFS;

	# Sort by
	local __offset=0;
	for (( __idx=0; $__idx < $__len; __idx++ )); do
		local __max=${__priorty[$__idx]};
		local __maxIdx=$__idx;

		if (( ${__exists[$__idx]} != 1 )); then
			for (( __jdx=0; $__jdx < $__len; __jdx++ )); do
				local __val=${__priorty[$__jdx]};

				if (( $__val > $__max && ${__exists[$__jdx]} != 1 )); then
					__max=$__val;
					__maxIdx=$__jdx;

					if (( $__idx >= 0 )); then
						((__idx--));
					fi
				fi
			done

			__seq[$__offset]=$__maxIdx;
			__exists[$__maxIdx]=1;

			((__offset++));
		fi
	done

	for __idx in ${__seq[@]}; do
		local __fn=${__items[$__idx]};
		__used=$N;
		$__fn callback;

		if [[ $__used == $Y ]]; then
			__usage="${__usage}$__idx $(now)\\r\\n";
		fi
	done

	fsWriteFile "$__file" $__usage;
}