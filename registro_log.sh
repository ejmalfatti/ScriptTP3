#!/bin/bash
IFS=""
FECHA=$(date "+%F")
DEV=$(mount | grep " on / " | cut -d' ' -f1)

FREE=$(df -mP $DEV | grep -iv "disponibles" | awk {'print$4'}) 

printf "%s\n" "$FECHA   Espacio libre: $FREE MB" >> /var/log/filesystem/FREE.log
