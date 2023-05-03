#!/bin/bash

# PAEDNEURO FILE RENAMER
#
# Finds eventlist.cef files in a directory and makes a copy 
# named after the other files from that subject.
# 
# Arguments:-
# 1. path to directory to check for eventlists
# 2. part of name denoting eventlist files (defaults to 'eventlist.cef' if not set)
# 
# Use: <path>/renamer.sh <directory to check> <(optional) eventlist identifier>
# eg. ./renamer.sh ./Ox0010101
# S Marchant 2020 simon.marchant@paediatrics.ox.ac.uk

## check for no input arguments
if [ $# -eq 0 ]; then
	echo "Enter directory to rename eventlist files in:"
	read dir
else
	dir="$1"
fi

## name in eventlist files
if [ "$2" != "" ]; then
	name=$2
else
	name="eventlist.cef"
fi

## check for trailing slash in directory name
if [[ ! "$dir" = */ ]]; then
	dir="$dir\/"
fi

## find eventlist files and rename
if [[ -n $(find $dir*$name*) ]] ## if there's something in first level
then for file in $dir*$name*;
	do
		subject="$( basename $file | head -c 8)";
		code=$( basename $(find $dir*$subject*_raw* -print -quit) | rev | cut -d'_' -f2 | rev );
		newfile="${file/$name/$code}_raw.cef";
		mv $file $newfile;
		echo "Renamed ${file} to ${newfile}";
	done
else for file in $dir**/*$name; ## if not check second level
	do
		subject="$( basename $file | head -c 8)";
		code=$( basename $(find $dir**/*$subject*_raw* -print -quit) | rev | cut -d'_' -f2 | rev );
		newfile="${file/$name/$code}_raw.cef";
	mv $file $newfile;
		echo "Renamed ${file} to ${newfile}";
	done
fi