library(readxl)
library(tidyverse)
library(igraph)
# Load data
compras <- read_excel('./data/raw/Compras y Contratos Municipales Cd. Juárez COPIA (3).xlsx', sheet = 2, col_names = T, range = 'A1:AL813')
# Explore complete cases
compras_complete_cases <- compras %>% drop_na()
# How many complete cases?
nrow(compras_complete_cases) # 0, zilch, nada
# create tibble and fix column names
compras_tibble <- as_tibble(compras, .name_repair = 'universal')
# Add an ID
compras_tibble_with_id <- rowid_to_column(compras_tibble, 'id')
# select only relevant columns
compras_tibble_with_id_relevant_columns <- compras_tibble_with_id %>% select(id,
                                                                             .PROCEDIMIENTO,
                                                                             .MATERIA,
                                                                             .ADMINISTRACIÓN,
                                                                             .EJERCICIO,
                                                                             .PROVEEDOR,
                                                                             UNIDAD.ADMINISTRATIVA.CONVOCANTE,
                                                                             DEPENDENCIA.SOLICITANTES,
                                                                             .CONCEPTO,
                                                                             .CATEGORÍA,
                                                                             .MONTO.TOTAL.O.MÁXIMO,
                                                                             PROCEDENCIA.DE.LOS.RECURSOS,
                                                                             .PERIODO.DE.CONTRATO..INICIO,
                                                                             .PERIODO.DE.CONTRATO..TERMINACIÓN,
                                                                             .FECHA.DE.CONTRATO,
                                                                             CONCURSANTES.2a.LICITACIÓN)
# Have another go at complete cases
compras_complete_cases <- compras_tibble_with_id_relevant_columns %>% drop_na() # 476 cases!
# Write out to file
write_excel_csv(compras_complete_cases, path = 'data/processed/compras_complete_cases.csv', col_names = T)
# Select columns to build graph
compras_complete_cases_graph <- compras_complete_cases %>% select(id,
                                                                  .PROVEEDOR,
                                                                  UNIDAD.ADMINISTRATIVA.CONVOCANTE,
                                                                  .MONTO.TOTAL.O.MÁXIMO)
# Write out to file
write_excel_csv(compras_complete_cases_relevant_columns, path = 'data/processed/compras_complete_cases_graph.csv', col_names = T)




