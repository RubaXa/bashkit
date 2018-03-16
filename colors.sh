#!/bin/bash

COLOR_CLR=$(tput sgr0);
COLOR_RESET=$(tput sgr0);

COLOR_ERR=$(tput setaf 1);
COLOR_DONE=$(tput setaf 2);
COLOR_INFO=$(tput setaf 4);
COLOR_WARN=$(tput setaf 5);
COLOR_VERBOSE=$(tput setaf 3);

colorize() {
	echo "$1$2$COLOR_RESET"
}
