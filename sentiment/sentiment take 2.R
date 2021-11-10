# install.packages("tidytext")
# install.packages("textdata")
suppressMessages(library(tidytext))
nrc = get_sentiments("nrc")

name = paste0("F:\\f21\\490\\chicago_words_by_book.csv")
raw = read_csv(name)
books = unique(raw$doc_id)
#for (ii in 1:329) {
for (ii in 1:2) {
  book_id = books[ii]
  cur.features = filter(raw, doc_id == book_id) 
  top1kwords = cur.features$word[1:1000]
  top1kfreqs = cur.features$n[1:1000]
  sent.list = rep(NA, 1000)
  sent.df = data.frame()
  for (jj in seq(1000)) {
    thisword = top1kwords[jj]
    thisfreq = top1kfreqs[jj]
    sent = nrc$sentiment[which(nrc$word == thisword)]
    if (!identical(sent, character(0))){
      #sent.list = append(sent.list, sent)
      print(paste("found", thisword, "with sent", sent))
      sent.df = rbind(sent.df, c(thisword, thisfreq, sent))
      #so this multiple-counts words that have multiple sentiment
      #e.g. "child" has sentiment "anticipation" "joy" "positive"
      #so in the dataframe it would have three instances of "child" and its freq
      #each with a different sentiment. Hm......
    }
  }
  #sent.list = sent.list[!is.na(sent.list)]
  sent.df = na.omit(sent.df)
  colnames(sent.df) <- c("word", "freq", "sentiment")
  #at some point freq becomes a character. ???
  sent.df$freq = as.numeric(sent.df$freq)
  ret = aggregate(freq ~ sentiment, sent.df, sum)
  #TODO:
  #right now ret is a single instance of a dataframe of sentiment and its frequency weighted by wordfrequency
  #so just need to 
  # 1) divide each frequency by the sum of frequencies
  # 2) put that into a bigger dataframe where each row is a book and each column is the sentiments
}

