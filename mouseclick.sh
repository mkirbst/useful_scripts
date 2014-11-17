#!/bin/bash
#
# This script simulates mouseclick n-times with a delay from m seconds
# useful eg for tinder :P
#
# sudo apt-get install xdotool


function usage {
        echo ;
        echo "ERROR - insufficient parameter count";
        echo "Usage: $0 DELAY[sec] CLICKCOUNT";
        echo ;
        exit 1;
}

##2 params required
if [ $# -ne 2 ] ; then  ## force parameters 
        usage;
fi

##########################################################

echo ;
echo "Beginning to click ${2} times with a delay from ${1} seconds"
echo "Press [ctrl]+[c] to abort..."
echo ;
echo ;
sleep 2;

for i in {5..1}
do
        echo "start in ${i}...";
        sleep 1;
done

echo ;
echo ; 

##########################################################

for j in $(eval echo {1..$2})
do
        echo "click nr ${j} an then sleep ${1} seconds...";
        sleep ${1};
        xdotool click 1;        # mouseclick left
done
