# This is a function that takes a vector of tweet_text, a list of positive
# words, and a list of negative words as arguments, and returns a data.frame
# with three columns: number of positive words, number of negative words,
# and sentiment score.

####### scan the pos/neg words
pos = scan("positive-words.txt", what = "character",comment.char = ";")
neg = scan("negative-words.txt", what = "character",comment.char = ";")
neg = c(neg,"wtf")
#######

getSentimentScore = function(tweet_text, pos, neg) {
  # text preprocessing remove retweet entities
  sentence = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweet_text)
  # remove all '@people'
  sentence = gsub("@\\w+", "", sentence)
  # remove all the punctuation
  sentence = gsub("[[:punct:]]", "", sentence)
  # remove all the control chracters, like \n or \r 
  sentence = gsub("[[:cntrl:]]", "", sentence)
  # remove numbers
  sentence = gsub("[[:digit:]]", "", sentence) 
  # remove html links
  sentence = gsub("http\\w+", "", sentence)
  # remove extra white spaces
  sentence = gsub("^\\s+|\\s+$", "", sentence)
  # convert to lower case
  sentence = iconv(sentence, "UTF-8", "ASCII", sub = "")
  sentence = tolower(sentence)
  # split into words
  word.list = strsplit(sentence, " ")
  # initialize vector to store score
  score = numeric(length(word.list)) # loop through each tweet
  positive = numeric(length(word.list))
  negative = numeric(length(word.list))
  for (i in 1:length(word.list)) {
    # compare our words to the dictionaries of positive # & negative terms
    pos.matches = match(word.list[[i]], pos) 
    neg.matches = match(word.list[[i]], neg)
    # match() returns the position of the matched term # or NA we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    # and conveniently enough, TRUE/FALSE will be # treated as 1/0 by sum():
    score[i] = sum(pos.matches) - sum(neg.matches)
    positive[i] = sum(pos.matches)
    negative[i] = sum(neg.matches)
  }
  return(data.frame(positive_word_count = positive, 
                    negative_word_count = negative,
                    sentiment_score = score))
}
