#!/bin/bash


#El [ $(ls -A EPNro1/entrada) ] nos devuelve un string, el if evalúa si ese string está vacío o no, si tiene algo entrará en el condicional TRUE, mientras que si no encuentra nada, entrará en el FALSE
#De este modo, evaluamos si la carpeta entrada tiene contenido o no
if [ "$(ls -A "EPNro1/entrada")" ]; then
 cat EPNro1/entrada/*.txt > EPNro1/salida/$FILENAME.txt #Si tiene contenido, dirigimos el contenido leido con cat, de todos los txt en entrada, hacia filenametxt
 mv EPNro1/entrada/*.txt EPNro1/procesado  #Y movemos todos los txt de entrada hacia procesado

else
 echo "No hay datos existentes dentro del directorio"
fi


