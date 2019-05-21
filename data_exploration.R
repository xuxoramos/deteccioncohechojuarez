library(tidyverse)
# Load saved files
compras_complete_cases <- read_csv('data/processed/compras_complete_cases.csv')
# promedio por categoría
compras_por_categoria <- compras_complete_cases %>% group_by(.CATEGORÍA) %>% summarise(mean(.MONTO.TOTAL.O.MÁXIMO))
# promedio por concepto
compras_por_concepto <- compras_complete_cases %>% group_by(.CONCEPTO) %>% summarise(mean(.MONTO.TOTAL.O.MÁXIMO))
# promedio por categoria_concepto
compras_por_categoria_concepto <- compras_complete_cases %>% group_by(CATEGORIA.DE.CONCEPTO) %>% summarise(mean(.MONTO.TOTAL.O.MÁXIMO, na.rm = T))

View(compras_por_categoria)
View(compras_por_concepto)
View(compras_por_categoria_concepto)