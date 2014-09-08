#!/bin/bash

# -a archive mode
# -H maintain hardlinks
# -v verbose
# --numeric-ids  If you are performing a backup which you think you might want to restore at some point in the future you should use --numeric-ids. This tells rsync to not attempt to translate UID <> userid or GID <> groupid which is very important for avoiding permission problems when restoring. 
# arcfour weakest and fastest ssh encryption 

rsync -aHxvz --progress --numeric-ids -e "ssh -c arcfour -o Compression=no -x" source destination
