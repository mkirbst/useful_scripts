#!/usr/local/bin/bash

# Skript setzt korrekt eingerichtetes vnstat auf Interface xl0 vorraus
# Skrit summiert Traffic der letzten 30  auf und gibt Ergebnis auf 
# /dev/cuau0 aus, welches unter FreeBSD die erste serielle Schnittstelle ist
# und an welcher ein Siemens BA66 Kassen-Display mit 4x20 Zeichen angeschlossen ist

T=0;    	## Traffic of the last 30 days in MB
TLEFT=0;	
/usr/local/bin/vnstat --dumpdb -i xl0 |  grep ^d | ( while read line;
do 
	T=$(( $T + `echo ${line} | awk 'BEGIN {FS = ";"} {print $4+$5}'` ));
done
T=$(( $T + 2 )) 		## +2MB aufrunden da NachkommaMB ignoriert werden
TLEFT=$(( 40000 - $T ))	##verbleibender Traffic = Trafficlimit 40GB - verbrauchter Traffic

## Ausgabe auf BA66
echo "" > /dev/cuau0
date +"%H:%M:%S  %d.%m.%Y" > /dev/cuau0
echo "$T MB used last 30d" > /dev/cuau0
echo "$TLEFT MB left 30d" > /dev/cuau0
## -ne damit letzte Zeile ohne Zeilenumbruch ausgegeben wird
echo -ne `/usr/local/bin/vnstat -i xl0 | sed -ne '5p' | awk '{print $7" "$8$9}'` > /dev/cuau0
)



