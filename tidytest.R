library(tidytext)
library(tidyverse)
library(tm)

metadata <- read_csv("F:\\f21\\490\\chicago_metadata.csv", col_names=T)
#doin the first 130 books for now, they end at 1890

#txt.to.import <- metadata$FILENAME[(which(metadata$PUBL_DATE <= 1890))]
mydir <- "F:\\f21\\490\\chicagotexts\\texts_public\\modified\\"
#corpus.list <- lapply(txt.to.import, function(x){VCorpus(DirSource(directory=mydir, pattern=x))})
#corpus.list <- VCorpus(DirSource(directory=mydir, pattern="*.txt"))
#test <- Corpus(VectorSource(DirSource(directory=mydir, pattern="*.txt")))
#preprocess <- function(corpus){
#  ret <- corpus %>% tm_map(content_transformer(tolower)) %>% tm_map(removePunctuation) %>% tm_map(stripWhitespace)
#  return(ret)
#}
#words1 <- Corpus(VectorSource(dat5))

#my.text <- preprocess(words1)
#dtm <- DocumentTermMatrix(my.text, control=list(stopwords=T, stemming=T))

#testcorpus <- tm_combine(corpus.list)
fuck <- VCorpus(DirSource(directory=mydir, pattern="corpusMerged.txt"))
tidy_corpus <- tidy(fuck)
#tidy_text <- unnest_tokens(tidy_corpus, words, text)
#ok sike tidy doesnt work for some reason something to do with encoding I think...
h = lapply(corpus.list, function(x){termFreq(x, control=list(stopwords=T, stemming=T, removePunctuation=T))})
