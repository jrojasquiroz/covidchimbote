#[Resultados] din_muertespandemia, din_muertes2019ok
#Ahora toca hacer la tabla dinámica
library(reshape2)   
library(data.table)

#1. [TRUCO] como en nuestra tabla dinámica habrá una sola columna (n° de casos), vamos a crear
#una columna llamada "ones" para engañar a la función del siguiente paso y no nos haga problemas
#https://www.youtube.com/watch?v=Fp3u7EEHXoA

muertesprepandemia <- data.frame(muertesprepandemia, ones=rep(NA,3475)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertesprepandemia$ones <- rep(1) #todas las filas van a repetir el valor 1

#calculo 2019 por separado por si acaso
muertes2019ok <- data.frame(muertes2019ok, ones=rep(NA,1793)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertes2019ok$ones <- rep(1) #todas las filas van a repetir el valor 1 


muertespandemia <- data.frame(muertespandemia, ones=rep(NA,4274)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertespandemia$ones <- rep(1) #todas las filas van a repetir el valor 1

#2. Además, como en este caso cada fila es una muerte, vamos a crear
#una variable que sirva de contador de muertes. En la práctica,
#es lo mismo que la nueva columna 'ones' pero para evitar errores de tipeo
#crearemos una nueva.

muertesprepandemia <- data.frame(muertesprepandemia, Muertes=rep(NA,3475)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertes2018ok$Muertes <- rep(1) #todas las filas van a repetir el valor 1

#Calculo 2019 por si acaso
muertes2019ok <- data.frame(muertes2019ok, Muertes=rep(NA,1793)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertes2019ok$Muertes <- rep(1) #todas las filas van a repetir el valor 1

muertespandemia <- data.frame(muertespandemia, Muertes=rep(NA,4274)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertespandemia$Muertes <- rep(1) #todas las filas van a repetir el valor 1

#3. Ahora sí hacemos las dinámicas de cada ola
din_muertespandemia <-dcast(muertespandemia, muertespandemia$FECHA~ones,sum,value.var="Muertes")
din_muertesprepandemia <- dcast(muertesprepandemia, muertesprepandemia$FECHA~ones,sum,value.var="Muertes")
din_muertes2019ok <- dcast(muertes2019ok, muertes2019ok$FECHA~ones,sum,value.var="Muertes") 
  
  #3.1. Le cambiamos el nombre a la columna "ones", que en realidad son los n° de casos
  names(din_muertespandemia) <- c("Fecha","NumMuertes")
  names(din_muertesprepandemia) <- c("Fecha","NumMuertes")
  names(din_muertes2019ok) <- c("Fecha","NumMuertes")