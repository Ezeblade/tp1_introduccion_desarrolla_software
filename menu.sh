#!/bin/bash
path_entrada="EPNro1/entrada"
path_salida="EPNro1/salida"
path_procesado="EPNro1/procesado"
CONTINUAR=0
while [ "$CONTINUAR" -eq 0 ];do
	echo -e "-------Menu-------\nElegi una opcion del menu\n1- Creacion de directorios\n2- Iniciar proceso de consolidacion\n3- Listado de alumnos ordenados por padron\n4- Las mejores 10 notas\n5- Consultar padron\n6- Salir\n-d- Borrar entorno"
	read opcion

	case $opcion in
		1) #Creacion del Menu
		 if [ -d "EPNro1" ]; then
		  echo "La carpeta EPNro1 ya existe"
		 else
		  mkdir -p "$path_entrada" && cp *.txt "$path_entrada"
		  mkdir -p "$path_salida"
		  mkdir -p "$path_procesado"
		  echo "Se ejecuto el entorno correctamente"
		 fi
		echo -e "\nElige otra opcion del menu porfavor"
		;;
		2) #Ejecutar consolidar.sh y copia archivos de entrada y pegarlo en salida. Pasa archivos entrada a pocesado
		 if [ -d "EPNro1" ]; then
		  echo "Se ejecuto el proceso correctamente"
		  cp consolidar.sh EPNro1
		  bash EPNro1/consolidar.sh
		 else
		  echo "Ejecuta la opcion 1 para crear las carpetas requeridas"
		 fi
		 echo -e "\nElige otra opcion del menu porfavor"
		;;

		3) #Alumnos ordenados por padron
		   # sort -n (ordena numericamente)
		   #awk busca patrones y toma por espacios, asi que printea padron nombre y apellido en este caso
		 if [ -f "$path_salida/$FILENAME.txt" ]; then
		  sort -n "$path_salida/$FILENAME.txt" | awk '{print $1, $2, $3}'
		 else
		  echo "No existe el archivo que se requiere para este proceso"
		 fi
		  echo -e "\nElige otra opcion del menu porfavor"
	 	;;

		4) #Mostrar 10 notas mas altas
		   # awk NF = busca en el ultimo campo | sort -n ordena de menor a mayor -nr ordena de mayor a menor
		 if [ -f "$path_salida/$FILENAME.txt" ]; then
		  echo "Las 10 mejores notas fueron:"
		  awk '{print $NF, $2, $3}' "$path_salida/$FILENAME.txt" | sort -nr | head -n 10
		 else
		  echo "No existe el archivo que se requiere para este proceso"
		 fi
		  echo -e "\nElige otra opcion del menu porfavor"
		;;

		5) # Coincidir padron pedido o alguno en los archivos
		   # Busca si existe el archivo y ademas grep(busca patrones) -q(no muestra nada por pantalla solo devuelve algo por salida) (^ = busca al inicio de la linea) ^$padron en $path_salida$FILENAME.txt)
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

		-d) #  Borrar entrono y matar procesos creados
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


