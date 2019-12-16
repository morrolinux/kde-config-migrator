#!/bin/bash

# This script is intended for personal use.
# You should be well aware that sharing your configurations with others without prior cleanup 
# could expose personal informations such as your opened file history.

if [[ $# -lt 1 ]]
then
	echo "usage: <backup> | <restore> <archive>"
	exit
fi

if [[ "$1" == "backup" ]]
then

	foldername="kde-config-"$(date +"%m-%d-%y_%H-%M-%S")
	mkdir $foldername
	cd $foldername
	echo "backing up configuration in ${foldername}.tar.gz"
	
	# Okular
	cp --parent ~/.local/share/kxmlgui5/okular/part.rc .
	cp --parent ~/.config/okularpartrc .
	cp --parent ~/.config/okularrc .
	
	# Gwenview
	cp --parent ~/.config/gwenviewrc .
	cp --parent ~/.local/share/kxmlgui5/gwenview/gwenviewui.rc .
	
	# Ark
	cp --parent ~/.config/arkrc .

	# Desktop right click simplification
	cp --parent ~/.config/plasma-org.kde.plasma.desktop-appletsrc .
	
	# Create the archive
	cd ..
	tar cjf ${foldername}.tar.gz $foldername

elif [[ "$1" == "restore" ]]
then

	if [[ "$2" == "" ]]
	then
		echo "please specify a valid archive name"
		exit
	fi

	foldername=$(echo "$2"|rev|cut -d'.' -f 3-|rev)
	tar xf "$2" -C "$foldername"
	cd ${foldername}/home/*
	
	for f in $(ls -A)
	do
		cp -R --parents $f ~/
	done

fi
