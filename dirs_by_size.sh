#!/bin/bash

# This script shows all subdirectories in the actual directory,
# sorted by their size

if [ $# -eq 0 ]
then 
        # no arguments, using actual directory as working directory
        WD=`pwd`
else
        WD=$1
fi

# du -bcs       # -b show filesize in byte not kilobyte # -c total # -s summarize
# sort -nr      # -n sort nummerical, -r sort reverse higo values on top low values on bottom 
# awk 'NR > 1'  # remove the first line in output, here is the first line the summary line from sort -nr

find $WD -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 du -bcs | sort -nr | awk 'NR > 1' |
awk 'BEGIN {} {
        if (    $1 > 1024^3 ) { printf "%5.1f GB  %s\n", $1/1024^3, $2} 
        else if ( $1 > 1024^2 ) { printf "%5.1f MB  %s\n", $1/1024^2, $2}
        else if ( $1 > 1024^1 ) { printf "%5.1f KB  %s\n", $1/1024^1, $2}
        else            printf "%5.1f  B  %s\n", $1, $2
}'
