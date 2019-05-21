library(tidyverse)
# Load saved files
compras_complete_cases <- read_csv('data/processed/compras_complete_cases.csv')
# Reglas para etiquetado 
# convenio modificatorio con monto significativo = amarillo
# proveedores recurrentes por administración = amarillo
# proveedores únicos con monto alto en un mismo categoria = amarillo, monto alto definido como a partir del 3er cuartil de la distribución - se debe hacer la distribución primero
# proveedores en más de 1 categoria
# plazos cortos: fecha fallo - fecha convocatoria, por categoria y por proveedor
# fechas de convocatorias por montos altos - madrugües a la ciudadanía, convocatorias en diciembre, enero, semana santa, etc.

