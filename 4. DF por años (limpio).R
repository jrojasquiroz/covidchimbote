#Replicamos lo hecho inicialmente. Esta plantilla servirá para usar
#de ahora en adelante. Lo mismo se hace para los años 2019 y 2020,
#cuyos resultados ya los tengo en Excel
#[RESULTADO] muertespandemia

#1.Importamos el df
library(readr)
rawsinadef <- read_delim("C:/Users/rojas/Google Drive/Documentos personales/Covid-19 Chimbote/fallecidos_sinadef(11-marzo).csv", 
                                           ";", escape_double = FALSE, col_types = cols(FECHA = col_date(format = "%Y-%m-%d")), 
                                           trim_ws = TRUE, skip = 2)
#Para ver cómo importar correctamente revisar el link: https://estadisticamente.com/trabajando-con-fechas-en-r/
#2.Vamos a hacer un df solo con datos de Chimbote y por causa no-violenta
#para 2021 y 2020-2021
#2.1. Primero cambiamos el nombre de la variable sobre muertes
#porque tiene espacios y R no los reconocerá así
require(reshape)
names(rawsinadef) #vemos los nombres  
names(rawsinadef)[18]="MUERTEVIOLENTA" #vimos que es la columna 18
names(rawsinadef)[12]="DISTRITO" #vimos que es la columna 12
names(rawsinadef)[14]="AÑO"
#https://www.youtube.com/watch?v=5QAiURKxFPI en este video hay otras formas de cambiar el nombre de las columnas
#2.2. Ahora sí elegimos por años y muertes no violentas

"muertes2020" = rawsinadef[ rawsinadef$AÑO == 2020 &
                              rawsinadef$DISTRITO == "CHIMBOTE", ]
"muertes2020" = muertes2020[ muertes2020$MUERTEVIOLENTA == "NO SE CONOCE" |
                               muertes2020$MUERTEVIOLENTA == "SIN REGISTRO",]

"muertes2020_2" = rawsinadef[ rawsinadef$AÑO == 2020 &
                                rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
"muertes2020_2" = muertes2020_2[ muertes2020_2$MUERTEVIOLENTA == "NO SE CONOCE" |
                                   muertes2020_2$MUERTEVIOLENTA == "SIN REGISTRO",]  
"muertes2020ok" = rbind(muertes2020,muertes2020_2)    



"muertes2021" = rawsinadef[ rawsinadef$AÑO == 2021 &
                              rawsinadef$DISTRITO == "CHIMBOTE", ]
"muertes2021" = muertes2021[ muertes2021$MUERTEVIOLENTA == "NO SE CONOCE" |
                               muertes2021$MUERTEVIOLENTA == "SIN REGISTRO",]

"muertes2021_2" = rawsinadef[ rawsinadef$AÑO == 2021 &
                                rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
"muertes2021_2" = muertes2021_2[ muertes2021_2$MUERTEVIOLENTA == "NO SE CONOCE" |
                                   muertes2021_2$MUERTEVIOLENTA == "SIN REGISTRO",]  
"muertes2021ok" = rbind(muertes2021,muertes2021_2)

rm(muertes2021, muertes2021_2, muertes2020, muertes2020_2)

#2.3.Calculamos muertes de toda la pandemia

"muertespandemia" = rbind(muertes2021ok,muertes2020ok)

rm(muertes2020ok,muertes2021ok)




#########################
######Ahora hacemos los mismos cálculos pero para muertes
#por todas las causas
"muertes2019" = rawsinadef[ rawsinadef$AÑO == 2019 &
                              rawsinadef$DISTRITO == "CHIMBOTE", ]
"muertes2019_2" = rawsinadef[ rawsinadef$AÑO == 2019 &
                                rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
"muertes2019_TC" = rbind(muertes2019,muertes2019_2)    


"muertes2020" = rawsinadef[ rawsinadef$AÑO == 2020 &
                              rawsinadef$DISTRITO == "CHIMBOTE", ]
"muertes2020_2" = rawsinadef[ rawsinadef$AÑO == 2020 &
                                rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
"muertes2020ok" = rbind(muertes2020,muertes2020_2)    


"muertes2021" = rawsinadef[ rawsinadef$AÑO == 2021 &
                              rawsinadef$DISTRITO == "CHIMBOTE", ]

"muertes2021_2" = rawsinadef[ rawsinadef$AÑO == 2021 &
                                rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]

"muertes2021ok" = rbind(muertes2021,muertes2021_2)

rm(muertes2019, muertes2019_2)
rm(muertes2021, muertes2021_2, muertes2020, muertes2020_2)

#2.3.Calculamos muertes de toda la pandemia

#muertes2019_TC ya está creado en el paso anterior
"muertespandemia_TC" = rbind(muertes2021ok,muertes2020ok)

rm(muertes2020ok,muertes2021ok)
