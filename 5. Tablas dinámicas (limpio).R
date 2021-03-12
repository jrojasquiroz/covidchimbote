#[Resultados] din_muertespandemia
#Ahora toca hacer la tabla dinámica
library(reshape2)   
library(data.table)

#1. [TRUCO] como en nuestra tabla dinámica habrá una sola columna (n° de casos), vamos a crear
#una columna llamada "ones" para engañar a la función del siguiente paso y no nos haga problemas
#https://www.youtube.com/watch?v=Fp3u7EEHXoA

muertespandemia <- data.frame(muertespandemia, ones=rep(NA,4343)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertespandemia$ones <- rep(1) #todas las filas van a repetir el valor 1

#2. Además, como en este caso cada fila es una muerte, vamos a crear
#una variable que sirva de contador de muertes. En la práctica,
#es lo mismo que la nueva columna 'ones' pero para evitar errores de tipeo
#crearemos una nueva.

muertespandemia <- data.frame(muertespandemia, Muertes=rep(NA,4343)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertespandemia$Muertes <- rep(1) #todas las filas van a repetir el valor 1

#3. Ahora sí hacemos las dinámicas de cada ola
din_muertespandemia <-dcast(muertespandemia, muertespandemia$FECHA~ones,sum,value.var="Muertes")

#3.1. Le cambiamos el nombre a la columna "ones", que en realidad son los n° de casos
names(din_muertespandemia) <- c("Fecha","NumMuertes")



################
##########Ahora para muertes por todas las causas

#1.
muertes2019_TC <- data.frame(muertes2019_TC, ones=rep(NA,1851)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertes2019_TC$ones <- rep(1) #todas las filas van a repetir el valor 1

muertespandemia_TC <- data.frame(muertespandemia_TC, ones=rep(NA,4396)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertespandemia_TC$ones <- rep(1) #todas las filas van a repetir el valor 1

#2. Además, como en este caso cada fila es una muerte, vamos a crear
#una variable que sirva de contador de muertes. En la práctica,
#es lo mismo que la nueva columna 'ones' pero para evitar errores de tipeo
#crearemos una nueva.

muertes2019_TC <- data.frame(muertes2019_TC, Muertes=rep(NA,1851)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertes2019_TC$Muertes <- rep(1) #todas las filas van a repetir el valor 1

muertespandemia_TC <- data.frame(muertespandemia_TC, Muertes=rep(NA,4396)) #le pedimos que cree una columna vacía con tantas filas como observaciones tiene el df
muertespandemia_TC$Muertes <- rep(1) #todas las filas van a repetir el valor 1

#3. Ahora sí hacemos las dinámicas de cada ola

din_muertes2019_TC <-dcast(muertes2019_TC, muertes2019_TC$FECHA~ones,sum,value.var="Muertes")
din_muertespandemia_TC <-dcast(muertespandemia_TC, muertespandemia_TC$FECHA~ones,sum,value.var="Muertes")

#3.1. Le cambiamos el nombre a la columna "ones", que en realidad son los n° de casos

names(din_muertes2019_TC) <- c("Fecha","NumMuertes")
names(din_muertespandemia_TC) <- c("Fecha","NumMuertes")

