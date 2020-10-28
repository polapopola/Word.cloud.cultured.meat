install.packages('tm')

library(tm)

##Loading in the data 
opinions <- read.csv("datasetMONDAY.csv", stringsAsFactors = FALSE)

##stringsAsFactors is set as FALSE because we dont want the words to be treated as factors

##combining all opinions together 
opinions_text <- paste(opinions$Notes, collapse = " ") 
##collapse here is saying,
##collapse this into one string and seperate each element with a space 

opinions_text 
##to see how it looks like, it should be a big chunk of text 

##Seting up a sorce for the text and the corpus 
opinions_source <- VectorSource (opinions_text)
corpus <- Corpus(opinions_source) 
##takes the text from vector and loads it into a corpus


##Cleaning 
corpus <- tm_map(corpus, content_transformer (tolower)) 
##makes everything lower-case
corpus <- tm_map(corpus, removePunctuation)
##removes punctuation
corpus <- tm_map(corpus, stripWhitespace) 
##creates only single space 
corpus <- tm_map(corpus, removeWords, stopwords ("english")) 
##consider do you want to use this 
 
##to check that the stopwords or very common words are use
stopwords ("english")

##making a document-term matrix

tdm <- TermDocumentMatrix(corpus)
tdm2 <- as.matrix(tdm)
v <- sort(rowSums(tdm2),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)


install.packages("RColorBrewer")
install.packages("wordcloud")

library(RColorBrewer)
library(wordcloud)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words=50, 
          random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))



