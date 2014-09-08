#!/bin/bash
####################
## Internet connection reconnect script for use with pfSense router distribution
## TODO: modify to work with https
####################


USER="root"
PW="YOURPASSWD"
ADDRESS="10.42.11.254"

echo "disconnecting ..."
curl -d interface=wan -d submit=Disconnect --basic https://$USER:$PW@$ADDRESS/status_interfaces.php > /dev/null 2>&1
sleep 3
echo "reconnecting ..."
curl -d interface=wan -d submit=Connect --basic https://$USER:$PW@$ADDRESS/status_interfaces.php > /dev/null 2>&1
