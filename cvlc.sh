#!/bin/bash
#
# Script to loop recordone of my favorite web radio stations
# 
# uses vlc console wrapper. To install, do:
#
# sudo apt-get install vlc-nox
#
# call the script every hour per cronjob, it will start new wav file. You can grab favorite songs from the wav files
# Files older than 24h should be overwritten because of the file name. To be shure add following cronjob that removes
# any wav files, older than 24h (remove trailing #):
# 0 * * * *       /usr/bin/nice -n 19 /usr/bin/find /home/m/housetime_looprecord/ -iname "*.wav" -type f -mmin +1440 -delete
#
# I use fanless Igel U700C thin client with 40GB laptop harddisk + Audigy 2 ZS PCI for this purpose.


RETRIES=5
RETRYDELAYSECS=60
TIMESTAMP=`date +%H-%M`
# crappy ~192kb/s stream, hoping for high bitrate in future :-)
URL="http://listen.housetime.fm/aacplus.pls"    
SAVEFOLDER="/home/m/housetime_looprecord/"
SAVEFILE=$SAVEFOLDER$TIMESTAMP"_started.wav";


## 00 kill all old vlc instances
killall vlc
sleep 1

## 01 check for online state
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
while [ $RETRIES -gt 0 ] && [ $? -ne 0 ];
do
#	echo "currently offline, wait and trying again...";
	((RETRIES--))
#	echo $RETRIES
	sleep $RETRYDELAYSECS;

	## quit script if after n retries no internet connection
	echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
	if [ $RETRIES -eq 0 ] && [ $? -ne 0 ];
	then
		echo "`date` giving up after ${RETRIES} retries due to faulty internet connection" >> ${SAVEFOLDER}fail.log
		exit 1
	fi
done

## 02 start stream recording to wav file
screen -dmS cvlc-record cvlc --sout "#transcode{acodec=s16l,channels=2,samplerate=44100}:std{access=file,mux=wav,dst=${SAVEFILE}}" $URL

## 03 start replay of the new wav file 
sleep 16	# give record process enough time to start
screen -dmS cvlc-play cvlc ${SAVEFILE}

