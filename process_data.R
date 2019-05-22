library(readxl)
library(tidyverse)
library(igraph)

# Functions
p <- c(0.2, 0.5, 0.8)

p_names <- map_chr(p, ~paste0(.x*100, "%"))

p_funs <- map(p, ~partial(quantile, probs = .x, na.rm = TRUE)) %>% 
  set_names(nm = p_names)

# Load data
compras <- read_excel('./data/raw/Compras y Contratos Municipales Cd. Juárez 2019-05-21.xlsx', sheet = 1, col_names = T, range = 'A1:AP893')
socios_padron_proveedores <- read_excel('./data/raw/Tabla de Socios Padron de Proveedores Juárez Excel.xlsx', sheet = 1, col_names = T, range = 'A1:E207')
directores_dependencias <- read_excel('./data/raw/Dependencias y Directores Cd. Juárez 2019.xlsx', sheet = 1, col_names = T, range = 'A1:B28')

# Turn comma-separated values in column Propietarios into new rows
socios_padron_proveedores_long <- socios_padron_proveedores %>% separate_rows(Propietarios, sep = ',')
# Write out to file
write_excel_csv(socios_padron_proveedores_long, path = 'data/processed/socios_padron_proveedores_long.csv', col_names = T)

# Explore complete cases for compras
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
                                                                             ADMINISTRACIÓN,
                                                                             .EJERCICIO,
                                                                             PROVEEDOR,
                                                                             UNIDAD.ADMINISTRATIVA.CONVOCANTE,
                                                                             DEPENDENCIA.SOLICITANTES,
                                                                             .CONCEPTO,
                                                                             .CATEGORÍA,
                                                                             CATEGORIA.DE.CONCEPTO,
                                                                             .MONTO.TOTAL.O.MÁXIMO,
                                                                             PROCEDENCIA.DE.LOS.RECURSOS,
                                                                             .PERIODO.DE.CONTRATO..INICIO,
                                                                             .PERIODO.DE.CONTRATO..TERMINACIÓN,
                                                                             .FECHA.DE.CONTRATO,
                                                                             LICITACIÓN...FECHA) # Will have to also add CONCURSANTES later
# Other relevant columns:
# - Convenio Modificatorio

# Have another go at complete cases
compras_complete_cases <- compras_tibble_with_id_relevant_columns #%>% drop_na()

# Remove SA de CV and S de RL DE CV
compras_complete_cases <- compras_complete_cases %>% mutate(PROVEEDOR = gsub(', S.A. DE C.V.','',PROVEEDOR))
compras_complete_cases <- compras_complete_cases %>% mutate(PROVEEDOR = gsub(', S. DE R.L. DE C.V.','',PROVEEDOR))

# Remove accents from CONCEPTO and PROVEEDOR
compras_complete_cases <- compras_complete_cases %>% mutate(PROVEEDOR = iconv(PROVEEDOR,from="UTF-8",to="ASCII//TRANSLIT"))
compras_complete_cases <- compras_complete_cases %>% mutate(.CONCEPTO = iconv(.CONCEPTO,from="UTF-8",to="ASCII//TRANSLIT"))


# Select columns to build graph
compras_complete_cases_graph <- compras_complete_cases %>% select(id,
                                                                  PROVEEDOR,
                                                                  UNIDAD.ADMINISTRATIVA.CONVOCANTE,
                                                                  .MONTO.TOTAL.O.MÁXIMO)

# Write out to file
write_excel_csv(compras_complete_cases_graph, path = 'data/processed/compras_complete_cases_graph.csv', col_names = T)
# Write out to file
write_excel_csv(compras_complete_cases, path = 'data/processed/compras_complete_cases.csv', col_names = T)
