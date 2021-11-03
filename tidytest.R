library(tidytext)
library(tidyverse)
library(tm)

metadata <- read_csv("F:\\f21\\490\\chicago_metadata.csv", col_names=T)

#txt.to.import <- metadata$FILENAME[(which(metadata$PUBL_DATE <= 1890))]
mydir <- "F:\\f21\\490\\chicagotexts\\texts_public\\modified\\"
#corpus.list <- lapply(txt.to.import, function(x){VCorpus(DirSource(directory=mydir, pattern=x))})
#corpus.list <- VCorpus(DirSource(directory=mydir, pattern="\\d+.txt"))
filelist <- list.files(path=mydir, pattern="\\d+.txt", full.names=T)
corpus.list <- readtext::readtext(filelist)
#ok........ for some reason........ corpus.list[[1]] is the filenames and corpus.list[[2]] is the corpuses as strings...
tidy.list <- lapply(corpus.list[[2]], function(x){tidy(VCorpus(VectorSource(x)))})
tidyprocess <- function(corpus){
  ret <- corpus %>% unnest_tokens(word, text) %>% anti_join(stop_words) %>% count(word, sort = TRUE)
  return(ret)
}
#test <- lapply(corpus.list, preprocess)
test2 <- lapply(tidy.list, tidyprocess)
#they're in the order of filelist. right..?
getdoc_id <- function(filename){
  ind = which(metadata$FILENAME == filename)
  lastname = metadata$AUTH_LAST[ind]
  title = metadata$TITLE[ind]
  title2 <- title %>% str_to_title %>% str_remove_all(" ")
  id <- paste(lastname, "_", title2, sep="")
  return(id)
}
docid.list <- lapply(corpus.list[[1]], getdoc_id) %>% unlist #lol

makeTable <- function(myTibble, docid){
  n = dim(myTibble)[1]
  doc_id = rep(docid, n)
  ret <- cbind(myTibble, doc_id)
  return(ret)
}
N = length(test2) #329
wordFreqsdoc_id.tbl <- list(rep(NA, N))
for(ii in 1:N){
  tbl.tmp <- makeTable(test2[[ii]], docid.list[ii])
  wordFreqsdoc_id.tbl[[ii]] <- tbl.tmp
}
out <- data.table::rbindlist(wordFreqsdoc_id.tbl, use.names=T)
write.table(out, "F:\\f21\\490\\chicago_words_by_book.csv", sep=",", row.names=F)

#for processing entire corpus
fuck <- VCorpus(DirSource(directory=mydir, pattern="corpusMerged.txt"))
tidy_corpus <- tidy(fuck)
h <- tidy_corpus %>% unnest_tokens(word, text) %>% anti_join(stop_words) %>% count(word, sort = TRUE)
#h$rank = 1:dim(h)[1]
#tidy_text <- unnest_tokens(tidy_corpus, words, text)
#ok sike tidy doesnt work for some reason something to do with encoding I think...
#h = lapply(corpus.list, function(x){termFreq(x, control=list(stopwords=T, stemming=T, removePunctuation=T))})
write.table(h, "F:\\f21\\490\\chicago_words.csv", sep=",", row.names=T)
