#[Resultados] mediamovil_mp, mediamovil_m2019
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

#2. Creamos la media móvil de 7 días para 2018-2019
mediamovil_mpp <- din_muertesprepandemia %>%
  select(Fecha, NumMuertes) %>%
  mutate(ContagiosSieteDias = rollmean(NumMuertes, k = 7, fill = NA),)

#3. Creamos la media móvil de 7 días para 2019 (por si acaso)
mediamovil_m2019 <- din_muertes2019ok %>%
  select(Fecha, NumMuertes) %>%
  mutate(ContagiosSieteDias = rollmean(NumMuertes, k = 7, fill = NA),)

#4. Grabamos para hacer los gráficos en Excel 
# porque [hashtag]soynuevoenRysufroconggplot

library(rio)

export(mediamovil_mp, "mediamovil_pandemia_ChimboteyNuevoChimbote.xlsx")
export(mediamovil_mpp, "mediamovil_prepandemia_ChimboteyNuevoChimbote.xlsx")
export(mediamovil_m2019, "mediamovil_2019_ChimboteyNuevoChimbote.xlsx")

#4. Graficamos
library(ggplot2)

ggplot(mediamovil_mp) +
 aes(x = Fecha, y = ContagiosSieteDias) +
 geom_line(size = 1L, colour = "#0c4c8a") +
 theme_minimal()
