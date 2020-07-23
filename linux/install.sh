#!/bin/bash

usage() {
	echo -e "Usage: \n"
	echo -e "\t-i|--install\tInstall layout"
	echo -e "\t-r|--remove\tRemove layout"
}

install() {
	sh ./src/icyd.install.sh
	sh ./src/icyd.postinst.sh
}

remove() {
	sh ./src/icyd.prerm.sh
	sh ./src/icyd.remove.sh
}

while [[ $# -gt 0 ]]; do
	key="$1"

	case $key in
		-i|--install)
			install
			shift
			;;
		-r|--remove)
			remove
			shift
			;;
		*)
			usage
			shift
			;;
	esac
done

