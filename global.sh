Y="Y"
N="N"
SECOND=$((1))
HOUR=$(($SECOND * 60));

default() {
	if [[ $1 == "" ]]; then
		echo ${@:2};
	else
		echo $1;
	fi
}

required() {
	if [[ $1 == "" ]]; then
		logErr "$2" $(emojiStatus err);
		exit 1;
	else
		echo "$1";
	fi
}