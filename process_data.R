library(readxl)
compras <- read_excel('./data/raw/Compras y Contratos Municipales Cd. Juárez COPIA (3).xlsx', sheet = 1, col_names = T, range = 'A1:AL813')