# TP-Bash
Aclaraciones

Todas las funciones y comandos utilizados son aclarados mediante comentarios especialmente para tener noción de qué realiza cada sección
Nuestra lógica fue tener previamente creado los datos y luego ser copiados dentro de la carpeta entrada. En lugar de moverlos los copiamos ya que cuando el usuario opte por borrar el entorno, había que volver a mover los datos
y sería una linea más de forma innecesaria, por ende creímos que era mejor simplemente crear previamente consolidar.sh y los datos, y a lo largo del código copiarlos según donde sean necesarios
De igual manera, al momento de correr "consolidar.sh" se lee el que está dentro de EPNro1, no el que está por fuera, en la "home", lo mismo pasa con los datos de entrada, se leen según en la carpeta que se encuentren
siempre y cuando sea dentro de "entrada/salida/procesado"
