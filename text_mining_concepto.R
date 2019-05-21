library(tm)  # for text mining
library(SnowballC) # for text stemming
library(wordcloud2) # word-cloud generator compras_complete_cases <- read_csv('data/processed/compras_complete_cases.csv')
conceptos <- compras_complete_cases %>% select(.MATERIA, .CONCEPTO)
# Create corpus
conceptos_corpus <- Corpus(VectorSource(.CONCEPTO))
# Convert the text to lower case
docs <- tm_map(conceptos_corpus, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("spanish"))
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# TDM
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)