Y="Y"
N="N"

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