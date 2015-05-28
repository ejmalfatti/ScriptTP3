#!/bin/bash

DEV=$(mount | grep " on / " | cut -d' ' -f1)

read -p "Ingrese la primer fecha: " FECHA1
read -p "Ingrese la segunda fecha: " FECHA2

NUM=$(grep -E "($FECHA1|$FECHA2)" /var/log/filesystem/FREE.log | awk {'print$4'})

NI=$(echo $NUM | awk {'print$1'})
NF=$(echo $NUM | awk {'print$2'})

if [ `expr $NF - $NI` -ge 0 ]; then
	echo "El filesystem raiz ($DEV) ha crecido: `expr $NF - $NI`"
elif [ `expr $NF - $NI` -le 0 ]; then
	echo "El filesystem raiz ($DEV) ha decrecido: `expr $NI - $NF`"
fi
