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

## name in eventlist files
if [ "$2" != "" ]; then
	name=$2
else
	name="eventlist.cef"
fi

## find eventlist files and rename
for file in $1*$name*;
do
subject="$( basename $file | head -c 8)";
code=$( basename $(find $1*$subject*_raw* -print -quit) | cut -d'_' -f2);
newfile="${file/$name/$code}.cef";
cp $file $newfile;
echo "Copied ${file} to ${newfile}";
done


