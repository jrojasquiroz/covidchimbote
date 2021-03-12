#[Resultados] mediamovil_mp, mediamovil_mpTC, mediamovil_2019TC

library("tidyverse")
library("lubridate")
library("fpp2")
library("zoo")
library("dplyr")
library("tidyr")

#1. Creamos la media móvil de 7 días para 2020-2021
mediamovil_mp <- din_muertespandemia %>%
  select(Fecha, NumMuertes) %>%
  mutate(ContagiosSieteDias = rollmean(NumMuertes, k = 7, fill = NA),)

#4. Grabamos para hacer los gráficos en Excel 
# porque [hashtag]soynuevoenRysufroconggplot

library(rio)

export(mediamovil_mp, "mediamovil_pandemia_ChimboteyNuevoChimbote_11marzo.xlsx")

#4. Graficamos
library(ggplot2)

ggplot(mediamovil_mp) +
  aes(x = Fecha, y = ContagiosSieteDias) +
  geom_line(size = 1L, colour = "#0c4c8a") +
  theme_minimal()


##################
#######Ahora para todas las causas

#1. 

mediamovil_2019TC <- din_muertes2019_TC %>%
  select(Fecha, NumMuertes) %>%
  mutate(ContagiosSieteDias = rollmean(NumMuertes, k = 7, fill = NA),)

mediamovil_mpTC <- din_muertespandemia_TC %>%
  select(Fecha, NumMuertes) %>%
  mutate(ContagiosSieteDias = rollmean(NumMuertes, k = 7, fill = NA),)

#4. Grabamos para hacer los gráficos en Excel 
# porque [hashtag]soynuevoenRysufroconggplot

export(mediamovil_2019TC, "muertes2019_TC.xlsx")
export(mediamovil_mpTC, "mediamovil_pandemiaTC_ChimboteyNuevoChimbote_11marzo.xlsx")

#4. Graficamos
library(ggplot2)

ggplot(mediamovil_2019TC) +
  aes(x = Fecha, y = ContagiosSieteDias) +
  geom_line(size = 1L, colour = "#0c4c8a") +
  theme_minimal()

library(ggplot2)

ggplot(mediamovil_mpTC) +
  aes(x = Fecha, y = ContagiosSieteDias) +
  geom_line(size = 1L, colour = "#0c4c8a") +
  theme_minimal()
