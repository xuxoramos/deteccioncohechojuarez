library(tidyverse)
library(ggplot2)
library(scales)

# Load saved files
compras_complete_cases <- read_csv('data/processed/compras_complete_cases.csv')
# promedio por categoría
# BACHEO PROMEDIO SIN NAs = 5212288
# BACHEO PROMEDIO CON NAs = 6225071.80 -- ESTA ES LA BUENA!
compras_por_categoria <- compras_complete_cases %>% 
  group_by(.CATEGORÍA) %>% 
  summarise(mean = mean(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            max = max(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            min = min(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            median = median(.MONTO.TOTAL.O.MÁXIMO, na.rm = T)) %>% na.omit()
compras_por_categoria_cuantiles <- compras_complete_cases %>% 
  group_by(.CATEGORÍA) %>% 
  summarise_at(vars(.MONTO.TOTAL.O.MÁXIMO), p_funs) %>% na.omit()
compras_por_categoria <- bind_cols(compras_por_categoria, compras_por_categoria_cuantiles) %>% select(-6)

# Plot histogram based on .CATEGORIA
pdf("categoria_monto_histogramas.pdf")
for (categoria in unique(compras_complete_cases$.CATEGORÍA)) {
  temp = filter(compras_complete_cases, .CATEGORÍA==categoria)
  binwidth_num = diff(range(temp$.MONTO.TOTAL.O.MÁXIMO))/30
  hist <- ggplot(filter(compras_complete_cases, .CATEGORÍA==categoria), aes(.MONTO.TOTAL.O.MÁXIMO)) +
                 geom_histogram(binwidth = binwidth_num) +
                 geom_density(aes(y=binwidth_num * ..count..)) +
                 theme_minimal() +
                 labs(x = "Monto total o máximo", y = "n") +
                 ggtitle(paste("Histograma de ", categoria)) +
                 scale_x_continuous(labels = dollar_format(suffix = "", prefix = "$"))
  print(hist)
}
dev.off()

# promedio por concepto
compras_por_concepto <- compras_complete_cases %>% 
  group_by(.CONCEPTO) %>% 
  summarise(mean(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            max(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            min(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            median(.MONTO.TOTAL.O.MÁXIMO, na.rm = T)) %>% na.omit()

# promedio por categoria_concepto
compras_por_categoria_concepto <- compras_complete_cases %>% 
  group_by(CATEGORIA.DE.CONCEPTO) %>% 
  summarise(mean(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            max(.MONTO.TOTAL.O.MÁXIMO, na.rm = T),
            min(.MONTO.TOTAL.O.MÁXIMO, na.rm = T), 
            median(.MONTO.TOTAL.O.MÁXIMO, na.rm = T)) %>% na.omit()

View(compras_por_categoria)
View(compras_por_concepto)
View(compras_por_categoria_concepto)
