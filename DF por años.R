#[Resultados] muertes2018ok, muertes2019ok, muertes2020ok, muertes2021ok, muertespandemia
#Para ver cómo jalar correctamente datos con fechas
#revisar esto: https://estadisticamente.com/trabajando-con-fechas-en-r/

#1. Jalamos el df
library(readr)
rawsinadef2 <- read_delim("C:/Users/rojas/Google Drive/Documentos personales/Covid-19 Chimbote/fallecidos_sinadef.csv", 
                                 ";", escape_double = FALSE, col_types = cols(FECHA = col_date(format = "%d/%m/%Y")), 
                                 trim_ws = TRUE, skip = 2)

library(readr)
rawsinadef4 <- read_delim("C:/Users/rojas/Google Drive/Documentos personales/Covid-19 Chimbote/fallecidos_sinadef(4marzo).csv", 
                                         ";", escape_double = FALSE, col_types = cols(FECHA = col_date(format = "%Y-%m-%d")), 
                                         trim_ws = TRUE, skip = 2)
View(fallecidos_sinadef_4marzo_) #ver mensaje previo para ver cómo jalar fechas correctamente

rm(fallecidos_sinadef)
#2.Vamos a hacer un df solo con datos de Chimbote y por causa no-violenta
#para 2021 y 2020-2021
  #2.1. Primero cambiamos el nombre de la variable sobre muertes
  #porque tiene espacios y R no los reconocerá así
  require(reshape)
  rawsinadef3=rename(rawsinadef3, c(MUERTE VIOLENTA="MUERTEVIOLENTA")) # NO ME FUNCIONÓ
  names(rawsinadef4) #vemos los nombres  
  names(rawsinadef4)[18]="MUERTEVIOLENTA" #vimos que es la columna 18
  names(rawsinadef4)[12]="DISTRITO" #vimos que es la columna 12
  names(rawsinadef4)[14]="AÑO"
  #https://www.youtube.com/watch?v=5QAiURKxFPI en este video hay otras formas de cambiar el nombre de las columnas
  #2.2. Ahora sí elegimos por años y muertes no violentas
  "muertes2018" = rawsinadef[ rawsinadef$AÑO == 2018 &
                                rawsinadef$DISTRITO == "CHIMBOTE", ]
  "muertes2018" = muertes2018[ muertes2018$MUERTEVIOLENTA == "NO SE CONOCE" |
                                 muertes2018$MUERTEVIOLENTA == "SIN REGISTRO",]
  
  "muertes2018_2" = rawsinadef[ rawsinadef$AÑO == 2018 &
                                rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
  "muertes2018_2" = muertes2018_2[ muertes2018_2$MUERTEVIOLENTA == "NO SE CONOCE" |
                                 muertes2018_2$MUERTEVIOLENTA == "SIN REGISTRO",]
    #2.2.1. Para unir df agregando filas, sabiendo que tiene las mismas
    #columnas y en el mismo orden, usamos rbind
    "muertes2018ok" = rbind(muertes2018,muertes2018_2)
    
    #Ahora repetimos los pasos 2.2 y 2.2.1 para cada año
  
  "muertes2019" = rawsinadef[ rawsinadef$AÑO == 2019 &
                                  rawsinadef$DISTRITO == "CHIMBOTE", ]
  "muertes2019" = muertes2019[ muertes2019$MUERTEVIOLENTA == "NO SE CONOCE" |
                                   muertes2019$MUERTEVIOLENTA == "SIN REGISTRO",]
    
  "muertes2019_2" = rawsinadef[ rawsinadef$AÑO == 2019 &
                                    rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
  "muertes2019_2" = muertes2019_2[ muertes2019_2$MUERTEVIOLENTA == "NO SE CONOCE" |
                                       muertes2019_2$MUERTEVIOLENTA == "SIN REGISTRO",]  
  "muertes2019ok" = rbind(muertes2019,muertes2019_2)
  
    #2.2.2. Vamos borrando los df que ya no nos sirven
    rm(muertes2020,muertes2020_2,muertes2021,muertes2021_2)
    
    "muertes2020" = rawsinadef[ rawsinadef$AÑO == 2020 &
                                  rawsinadef$DISTRITO == "CHIMBOTE", ]
    "muertes2020" = muertes2020[ muertes2020$MUERTEVIOLENTA == "NO SE CONOCE" |
                                   muertes2020$MUERTEVIOLENTA == "SIN REGISTRO",]
    
    "muertes2020_2" = rawsinadef[ rawsinadef$AÑO == 2020 &
                                    rawsinadef$DISTRITO == "NUEVO CHIMBOTE", ]
    "muertes2020_2" = muertes2020_2[ muertes2020_2$MUERTEVIOLENTA == "NO SE CONOCE" |
                                       muertes2020_2$MUERTEVIOLENTA == "SIN REGISTRO",]  
    "muertes2020ok" = rbind(muertes2020,muertes2020_2)
    
    
    "muertes2021" = rawsinadef4[ rawsinadef4$AÑO == 2021 &
                                  rawsinadef4$DISTRITO == "CHIMBOTE", ]
    "muertes2021" = muertes2021[ muertes2021$MUERTEVIOLENTA == "NO SE CONOCE" |
                                   muertes2021$MUERTEVIOLENTA == "SIN REGISTRO",]
    
    "muertes2021_2" = rawsinadef4[ rawsinadef4$AÑO == 2021 &
                                    rawsinadef4$DISTRITO == "NUEVO CHIMBOTE", ]
    "muertes2021_2" = muertes2021_2[ muertes2021_2$MUERTEVIOLENTA == "NO SE CONOCE" |
                                       muertes2021_2$MUERTEVIOLENTA == "SIN REGISTRO",]  
    "muertes2021ok" = rbind(muertes2021,muertes2021_2)
    
  #2.3.Calculamos muertes de toda la pandemia
  
    "muertespandemia" = rbind(muertes2021ok,muertes2020ok)
    "muertesprepandemia" = rbind(muertes2018ok,muertes2019ok)
    