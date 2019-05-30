# Libraries
library(tidyverse)
library(networkD3)

# Set working path R Studio
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load saved files
df <- read_csv('data/processed/compras_complete_cases_graph.csv')
df <- df %>% drop_na()
df$id <- NULL

# Rename columns
links <- df %>%
  rename(
    source = PROVEEDOR,
    target = UNIDAD.ADMINISTRATIVA.CONVOCANTE,
    value = .MONTO.TOTAL.O.MÁXIMO
  )

# Create nodes dataset
c(as.character(links$source), as.character(links$target)) %>%
  as.tibble() %>%
  group_by(value) %>%
  summarize(n=n()) -> nodes
colnames(nodes) <- c("name", "size")

nodes$group <- 1
nodes$group[nodes$name %in% (unique(links$target))] <- 2
nodes = as.data.frame(nodes)

# Replace node values
links$source <- match(links$source, nodes$name)
links$target <- match(links$target, nodes$name)
links$value <- (links$value - min(links$value)) / (max(links$value) - min(links$value)) * 100
links = as.data.frame(links)

# Reindex to 0
links$source <- links$source - 1
links$target <- links$target - 1

# Create graph with legend and varying node radius
forceNetwork(Links = links,
             Nodes = nodes,
             Source = "source",
             Target = "target",
             Value = "value",
             NodeID = "name",
             Nodesize = "size",
             Group = "group",
             height = 2000,
             width = 2000,
             linkDistance = 100,
             radiusCalculation = "Math.sqrt(d.nodesize)+6",
             opacity = 0.9,
             bounded = TRUE,
             opacityNoHover = TRUE,
             zoom = T) %>% saveNetwork(file = 'network_graph.html')
