#!/bin/bash
VACIO=" "
DEV=$(mount | grep " on / " | cut -d' ' -f1)
echo "===== Debe ingresar una fecha del tipo YYYY-MM-DD ====="

read -p "Ingrese la primer fecha mayor: " FECHA1
read -p "Ingrese la segunda fecha menor: " FECHA2
echo

NUM=$(grep -E "($FECHA1|$FECHA2)" /var/log/filesystem/FREE.log | awk {'print$4'})

NI=$(echo $NUM | awk {'print$1'})
NF=$(echo $NUM | awk {'print$2'})

if [ $NI = $VACIO 2>/dev/null ] || [ $NF = $VACIO 2>/dev/null ];then
    echo "El filesystem raiz ($DEV) ha crecido: Error en las fechas o informacion incompleta"
else
    if [ `expr $NF - $NI` -ge 0 ]; then
	    echo "El filesystem raiz ($DEV) ha crecido: `expr $NF - $NI` MB"
    elif [ `expr $NF - $NI` -le 0 ]; then
	    echo "El filesystem raiz ($DEV) ha decrecido: `expr $NF - $NI` MB"
    fi
fi
echo
echo "Archivos modificados desde la fecha $FECHA1 hasta la fecha $FECHA2"
echo
grep -e "$FECHA1" -e "$FECHA2" /var/log/filesystem/ARCHIVES.log | sort -u

