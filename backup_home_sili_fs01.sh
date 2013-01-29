#!/bin/bash                                                                                                                                                                                                
TIMESTAMP=`date "+%Y%m%d%H%M%S"`                                                                                                                                                                           
FILENAME="BACKUP_${TIMESTAMP}_marlap01_home_m.tgz"                                                                                                                                                         
SHARE_MOUNTED=`mount | grep "//fs01/m"`                                                                                                                                                                    
                                                                                                                                                                                                           
## echo "DEBUG_FILENAME: $FILENAME"                                                                                                                                                                        
                                                                                                                                                                                                           
if [ "$SHARE_MOUNTED" == "" ]  ; then                                                                                                                                                                      
        echo "[`date +%Y%m%d%H%M%S`] !! share not mounted, aborting backup ... !!"                                                                                                                         
else                                                                                                                                                                                                       
        echo "[`date +%Y%m%d%H%M%S`] begin creating local backup file "
        tar -vzcf /var/backups/$FILENAME --exclude=shares --exclude=mnt --exclude=archive --exclude=.cache --exclude=*/lost+found /home/m

        echo "[`date +%Y%m%d%H%M%S`] local backup complete, begin transferring to backup server ..."
        mv /var/backups/$FILENAME /home/m/shares/sili_fs01_home/backup/MARLAP01/

        echo "[`date +%Y%m%d%H%M%S`] backup done  ..."
fi

