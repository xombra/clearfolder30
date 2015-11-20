#!/bin/bash
# by Xombra
# Licence: GPL-2
# Clear contents of a folder every 30 min

fechaactualmenos30min=$(date +%s --date='-30 min')
fechaactual=$(date)
SAVEIF=$IFS

directorio="temporales"

IFS=$(echo -en "\n\b")

if [ -d $directorio ]; then

	for file in $(ls $directorio)
		do

			archivo=${file%%}
			fechaarchivo=$(stat -c "%Y" $archivo)
			fechafile=${fechaarchivo%% *}
			echo "* $fechaarchivo | $fechaactualmenos30min"
			if [ $fechaactualmenos30min -gt $fechaarchivo ]; then
				rm -f -R  $directorio/$archivo
				echo "Eliminado fecha - $fechaactual | Archivo $archivo" >> /var/log/tempBorrados.log
			fi

		done

else
	echo "No existe el Directorio -> $directorio "
fi

IFS=$SAVEIFS
exit 0
