#!/bin/bash

emojiListOK=(👍 👊 🤘 👌 💪 ✨ 🌟 🏅 🎖);
emojiListError=(💩 😱 😡 💔 🚨 💥);
emojiListDone=(🎀 💎 🍺 🎂 🍬 🏆 🎯 💖);

emojiStatus() {
	if [[ "$@" == "ok" ]]; then
		list=(${emojiListOK[@]});
	elif [[ "$@" == "err" ]]; then
		list=(${emojiListError[@]});
	else
		list=(${emojiListDone[@]});
	fi

	idx=$(( $RANDOM % ${#list[*]} ))
	echo "${list[idx]}";
}
