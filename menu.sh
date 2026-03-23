#!/bin/bash
#Declaramos las rutas en variables para algo mas legible y dado que se repite mucho
path_entrada="EPNro1/entrada"
path_salida="EPNro1/salida"
path_procesado="EPNro1/procesado"

#Vamos a utilizar la variable continuar como parametro booleano, de modo que, hasta que el usuario no seleccione la opcion 6 de Salir, el menu continue imprimiendose
CONTINUAR=0

while [ "$CONTINUAR" -eq 0 ];do
	echo -e "-------Menu-------\nElegi una opcion del menu\n1- Creacion de directorios\n2- Iniciar proceso de consolidacion\n3- Listado de alumnos ordenados por padron\n4- Las mejores 10 notas\n5- Consultar padron\n6- Salir\n-d- Borrar entorno"
	read opcion  #Imprimimos las opciones y analizamos cual fue la eleccion del usuario, utilizamos un case para acceder al bloque del caso elegido

	case $opcion in
		1) #Creacion del EPNro1 unicamente si no existe ya previamente 
		 if [ -d "EPNro1" ]; then
		  echo "La carpeta EPNro1 ya existe"
		 else
		  mkdir -p "$path_entrada" && cp *.txt "$path_entrada" #Creamos las carpetas, usamos la flag -p para que se creen los directorios intermedios en caso de no existir, y copiamos los archivos de entrada a la carpeta entrada
		  mkdir -p "$path_salida"
		  mkdir -p "$path_procesado"
		  echo "Se ejecuto el entorno correctamente"
		 fi
		echo -e "\nElige otra opcion del menu porfavor" #Una ver terminado cada caso segun la opcion que elije el usuario, se pide nuevamente otra opcion de menu, le agregamos el salto de linea por estetica
		;;
		2) #Ejecutar consolidar.sh y copia archivos de entrada y pegarlo en salida. Pasa archivos entrada a pocesado
		 if [ -d "EPNro1" ]; then
		  echo "Se ejecuto el proceso correctamente" #En cada uno de los casos mandamos un echo para hacer saber al usuario que la opcion fue ejecutada exitosamente
		  cp consolidar.sh EPNro1  #Copiamos consolidar a EPNro1 como indica la consigna y lo corremos
		  bash EPNro1/consolidar.sh
		 else
		  echo "Ejecuta la opcion 1 para crear las carpetas requeridas"  #Y pusimos la condicion de que debe crearse primero la carpeta con la opcion 1 para poder ejecutar esta opcion
		 fi
		 echo -e "\nElige otra opcion del menu porfavor"
		;;

		3) #Alumnos ordenados por padron
		   # sort -n (ordena numericamente) 
		   #awk, analiza por lineas, busca patrones y toma por espacios, asi que printea padron, nombre y apellido en este caso
		 if [ -f "$path_salida/$FILENAME.txt" ]; then #Primero chequeamos la existencia del archivo filename
		  sort -n "$path_salida/$FILENAME.txt" | awk '{print $1, $2, $3}' #Tomamos los primeros 3 espacios de cada linea y los printea 
		 else
		  echo "No existe el archivo que se requiere para este proceso"
		 fi
		  echo -e "\nElige otra opcion del menu porfavor"
	 	;;

		4) #Mostrar 10 notas mas altas
		   # awk NF = busca en el ultimo campo | sort -n ordena de menor a mayor -nr ordena de mayor a menor y head -n 10 pone como condicion agarrar las primeras 10 lineas
		 if [ -f "$path_salida/$FILENAME.txt" ]; then
		  echo "Las 10 mejores notas fueron:"
		  awk '{print $NF, $2, $3}' "$path_salida/$FILENAME.txt" | sort -nr | head -n 10
		 else
		  echo "No existe el archivo que se requiere para este proceso"
		 fi
		  echo -e "\nElige otra opcion del menu porfavor"
		;;

		5) #Coincidir padron pedido en los archivos
		   #Busca si existe el archivo y ademas grep(busca patrones) -q(no muestra nada por pantalla solo devuelve algo por salida) (^ = busca al inicio de la linea) ^$padron en $path_salida$FILENAME.txt)
		   #En resumen, este grep va a buscar al inicio de cada linea el padron solicitado, si existe, se ejecuta el grep nuevamente pero esta vez lo imprime
		 if [ -f "$path_salida/$FILENAME.txt" ]; then
		  echo "Ingrese un numero de padron:"
		  read padron

		  if grep -q "^$padron" "$path_salida/$FILENAME.txt"; then
		   echo "El usuario con el padron pedido es:"
		   grep "^$padron" "$path_salida/$FILENAME.txt"
		  else
		   echo "No hay ningun usuario con el padron: $padron"
		  fi
		 else
		 echo "No existe el archivo que se requiere para este proceso"
	         fi
	        echo -e "\nElige otra opcion del menu porfavor"
		;;

		6) # Salir del bucle (menu)
		 echo "Has salido del menu"
		 CONTINUAR=1
		;;

		-d) #  Borrar entorno y matar procesos creados. Primero verifica si existe la carpeta, despues se elimina junto a todo su interior
		if [ -d "EPNro1" ]; then 
		 echo "Se elimino la carpeta EPNro1"
		 rm -r EPNro1
		else
		 echo "No existe un entorno"
		fi
		echo -e "\nElige otra opcion del menu porfavor"
		;;

		*) # Cualquier opcion no dentro de las opciones
		 echo -e "\nOpcion no valida. Elige otra opcion del menu porfavor"
		;;

	esac
done


