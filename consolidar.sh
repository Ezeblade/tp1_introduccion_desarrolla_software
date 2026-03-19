#!/bin/bash

#cp *.txt EPNro1/salida
#El [ $(ls -A EPNro1/entrada) ] nos devuelve un string, el if evalúa si ese string está vacío o no, si tiene algo entrará en el condicional TRUE, mientras que si no encuentra nada, entrará en el FALSE
#De este modo, evaluamos si la carpeta entrada tiene contenido o no
if [ "$(ls -A "EPNro1/entrada")" ]; then
 cat EPNro1/entrada/*.txt > EPNro1/salida/$FILENAME.txt
 mv EPNro1/entrada/*.txt EPNro1/procesado

else
 echo "No hay datos existentes dentro del directorio"
fi


