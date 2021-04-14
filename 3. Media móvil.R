#[Resultados] mediamovil_mp, mediamovil_mpTC, mediamovil_2019TC

library("tidyverse")
library("dplyr")
library("tidyr")

#1. Creamos la media móvil de 7 días para 2020-2021
mediamovil_mp <- din_muertespandemia %>%
  select(Fecha, NumMuertes) %>%
  mutate(ContagiosSieteDias = rollmean(NumMuertes, k = 7, fill = NA),)
