#!/bin/bash
IFS=""

check_dir(){
    DIR="/var/log/filesystem"
    if [ -d $DIR ]; then
        echo "Fichero existe"
    else
        mkdir -p $DIR
    fi
}

FECHA=$(date "+%F")
DEV=$(mount | grep " on / " | cut -d' ' -f1)

FREE=$(df -mP $DEV | grep -iv "disponibles" | awk {'print$4'}) 

check_dir

find / -type f -mtime -1 -exec ls -gGh --full-time '{}' \; | awk {'print$4,$5,$7'} >> /var/log/filesystem/ARCHIVES.log

printf "%s\n" "$FECHA   Espacio libre: $FREE MB" >> /var/log/filesystem/FREE.log
