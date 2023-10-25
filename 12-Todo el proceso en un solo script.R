#1.Importamos el df
library(readr)
rawsinadef <- read_delim("C:/Users/rojas/Downloads/fallecidos_sinadef.csv", 
                         ";", escape_double = FALSE, col_types = cols(FECHA = col_date(format = "%d/%m/%Y")), 
                         trim_ws = TRUE)

#2.Vamos a hacer un df solo con datos de los distritos que nos
#interesan y por Covid para 2020-2021
#2.1. Primero cambiamos el nombre de la variable sobre muertes
#porque tiene espacios y R no los reconocer? as?
require(reshape)
names(rawsinadef) #vemos los nombres  
names(rawsinadef)[20]="CAUSA_A" #Cambiamos el "DEBIDO A (CAUSA A)" por esto
names(rawsinadef)[22]="CAUSA_B"
names(rawsinadef)[24]="CAUSA_C"
names(rawsinadef)[24]="CAUSA_D"
#Se cambian solo desde A a D, debido a lo que señala
#el Informe técnico para actualizar cifra de fallecidos
#https://cdn.www.gob.pe/uploads/document/file/1920118/Informe%20final%20del%20grupo%20de%20trabajo%20te%CC%81cnico%20con%20cifra%20de%20fallecidos%20por%20la%20COVID-19.pdf.pdf

#2.2. Ahora si elegimos por AÑOS y por los motivos que señala el
#Informe Técnico
library(dplyr)

muertespandemia <- rawsinadef %>%
  filter( AÑO == 2020 |
            AÑO == 2021) %>%
  filter(DISTRITO == "CHIMBOTE" |
         DISTRITO == "NUEVO CHIMBOTE" ) %>%
  filter(grepl("COVID", CAUSA_A) 
         | grepl("COVID", CAUSA_B)| 
           grepl("COVID", CAUSA_C)| 
           grepl("COVID", CAUSA_D)
         | grepl("CORONAVIRUS", CAUSA_A)| 
           grepl("CORONAVIRUS", CAUSA_B)| 
           grepl("CORONAVIRUS", CAUSA_C)| 
           grepl("CORONAVIRUS", CAUSA_D)| 
           grepl("COV2", CAUSA_A) | grepl("COV2", CAUSA_B)
         | grepl("COV2", CAUSA_C) | grepl("COV2", CAUSA_D) 
         | grepl("COV-2", CAUSA_A) | grepl("COV-2", CAUSA_B)
         | grepl("COV-2", CAUSA_C) | grepl("COV-2", CAUSA_D) |
           grepl("SARS", CAUSA_A) | grepl("SARS", CAUSA_B)
         | grepl("SARS", CAUSA_C) | grepl("SARS", CAUSA_D))

#2.3.Calculamos muertes de toda la pandemia
"muertespandemia" = rbind(muertes2021,muertes2020)

#3. [TRUCO] como en nuestra tabla dinámica habrá una sola columna (n° de casos), vamos a crear
#una columna llamada "ones" para engañar a la función del siguiente paso y no nos haga problemas
#https://www.youtube.com/watch?v=Fp3u7EEHXoA

muertespandemia$Muertes <- rep(1) #todas las filas van a repetir el valor 1

#4. Ahora sí hacemos la dinámica
din_muertespandemiados <- muertespandemia %>%
  group_by(FECHA) %>%
  summarise(Muertes=sum(Muertes))

#4.1. Le cambiamos el nombre a la columna "ones", que en realidad son los n° de casos
names(din_muertespandemia) <- c("Fecha","NumMuertes")