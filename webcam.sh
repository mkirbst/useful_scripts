#!/bin/bash

DEST_DIR="$HOME/Pictures/Webcam"
CAM="/dev/video0"	##integrated webcam
LOGFILE="$HOME/.log/webcam.log"

## detect if external webcam is connected and use this in this case
if [ -a /dev/video1 ]	##if /dev/video1 exists
then
  CAM="/dev/video1"
fi

echo "Using video device ${CAM}"

if [ ! -e $DEST_DIR ]; then
    mkdir $DEST_DIR
fi

## dont use the day dir, put all files to ~/Pictures/Webcam/
## DAY_DIR="$DEST_DIR/`date +'%Y%m%d'`"
## if [ ! -e $DAY_DIR ]; then
##     mkdir $DAY_DIR
## fi

## PIC_FILE="$DAY_DIR/webcam-`date +'%Y%m%d%H%M%S'`.jpg"
PIC_FILE="$DEST_DIR/`date +'%Y%m%d%H%M%S'`_webcam_gstlaunch.jpg"
TMP_FILE="$DEST_DIR/tmp.jpg"
TMP_FILE2="$DEST_DIR/tmp2.jpg"
TMP_FILE3="$DEST_DIR/tmp3.jpg"

##  grab picture from webcam
## gst-launch v4l2src num-buffers=1 \! jpegenc \! filesink location=$PIC_FILE ## pics too dark
## gst-launch v4l2src device=$CAM num-buffers=1 \! ffmpegcolorspace  \! videobalance brightness=0.3 \! jpegenc \! filesink location=$TMP_FILE 
##gst-launch v4l2src device=$CAM num-buffers=1 \! ffmpegcolorspace \! jpegenc \! filesink location=$TMP_FILE > $LOGFILE
fswebcam -d $CAM -S 12 -r 1920x1080 --no-banner --jpeg 100 $TMP_FILE > $LOGFILE

## put date and time into picture on upper left corner
convert -pointsize 32 -font /usr/share/fonts/truetype/ubuntu-font-family/UbuntuMono-R.ttf -fill white -stroke black -strokewidth 1 -draw "text 10,20 \"$(date "+%H:%M %d.%m.%Y"|sed -e ' s/\"/\\\"/g' )\"" $TMP_FILE $TMP_FILE2 >> $LOGFILE
##convert -pointsize 32 -font /usr/share/fonts/truetype/ubuntu-font-family/UbuntuMono-R.ttf -fill white -stroke black -strokewidth 1 -draw "text 300,20 \"$(echo "${CAM}" )\"" $TMP_FILE2 $TMP_FILE3
convert -pointsize 32 -font /usr/share/fonts/truetype/ubuntu-font-family/UbuntuMono-R.ttf -fill white -stroke black -strokewidth 1 -draw "text 300,20 \"$(udevadm info -a -p $(udevadm info -q path -n ${CAM}) | grep ATTR{name} | awk 'BEGIN { FS="\"" } { print $2 }')\"" $TMP_FILE2 $PIC_FILE >> $LOGFILE
## convert -pointsize 32 -font /usr/share/fonts/truetype/ubuntu-font-family/UbuntuMono-R.ttf -fill white -stroke black -strokewidth 1 -draw "text 10,20 \"$(date "+%H:%M %d.%m.%Y" )\"" $TMP_FILE $TMP_FILE2

rm $TMP_FILE
rm $TMP_FILE2
rm $TMP_FILE3

sleep 1

## fswebcam
fswebcam -d $CAM -S 30 -r 1920x1080 --jpeg 100 $DEST_DIR/`date +"%Y%m%d%H%M%S"`_webcam_fswebcam_30frames.jpg >> $LOGFILE
fswebcam -d $CAM -S 25 -r 1920x1080 --jpeg 100 $DEST_DIR/`date +"%Y%m%d%H%M%S"`_webcam_fswebcam_25frames.jpg >> $LOGFILE
fswebcam -d $CAM -S 20 -r 1920x1080 --jpeg 100 $DEST_DIR/`date +"%Y%m%d%H%M%S"`_webcam_fswebcam_20frames.jpg >> $LOGFILE
fswebcam -d $CAM -S 15 -r 1920x1080 --jpeg 100 $DEST_DIR/`date +"%Y%m%d%H%M%S"`_webcam_fswebcam_15frames.jpg >> $LOGFILE
fswebcam -d $CAM -S 12 -r 1920x1080 --jpeg 100 $DEST_DIR/`date +"%Y%m%d%H%M%S"`_webcam_fswebcam_12frames.jpg >> $LOGFILE
