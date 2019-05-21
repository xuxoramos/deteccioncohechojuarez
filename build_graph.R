library(tidyverse)
library(igraph)
library(networkD3)
# Load saved files
compras_complete_cases_graph <- read_csv('data/processed/compras_complete_cases_graph.csv')
# Plot graph selecting all columns EXCEPT the ID
simpleNetwork(select(compras_complete_cases_graph, c(-1)))