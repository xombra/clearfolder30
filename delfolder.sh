#!/bin/bash
# by Xombra
# Licence: GPL-2
# Clear contents of a folder every 30 min

if [[ $USER != root ]]; then
	echo -e "\e[00;31mERROR: You must be root to run script\e[00m"
	echo -e "\e[00;31mERROR: Debes ser ROOT para ejecutar el script\e[00m"
	exit 1
fi

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
