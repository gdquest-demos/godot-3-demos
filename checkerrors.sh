#!/bin/bash

VERBOSE=false
ERRFOUND=false
ERRCOUNT=0

LOGFILE=".checkerrors.log.tmp"

case $1 in
	-v|--verbose)
		VERBOSE=true
	;;
esac

touch "$LOGFILE";
ack -g "\.godot" | sed -r "s/(.+)\/([^\/]+)/\1/" | ( while read in;
do 
	ERRFOUND=false
	timeout 1 godot --path "$in" &> "$LOGFILE" || grep "ERROR" -i "$LOGFILE" &> /dev/null && printf "Error found in: $in\n" && ERRFOUND=true;
	if [ "$ERRFOUND" = true ] ; then
		if [ "$VERBOSE" = true ] ; then
			printf "\n";
			cat "$LOGFILE";
			printf "\n**********************************************************\n\n";
		fi
		ERRCOUNT=$((ERRCOUNT+1));
	fi
done && echo "Found $ERRCOUNT files with errors." )
rm "$LOGFILE"
