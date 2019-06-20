  
  gsub("<[^<>]*>","",Tweets2Use$statusSource)
  --------
  #Tweets#
  --------
  #make it into data frame
  load("xxx.Rdata")
  dsTweets = twListToDF(dsTweets)
  
  #Hist of density and kernal density estimate (edge effects)
  hist(dsTweets$retweetCount)
  count = c(-dsTweets$retweetCount,dsTweets$retweetCount)
  error = density(count,from = 0)
  hist(dsTweets$retweetCount,freq = FALSE)
  lines(error$x,2*error$y,col=2)
  
  #Number of tweets per user
  temp = table(morewithretweets$screenName)
  barplot(sort(temp,decreasing = T),las=2,xlim = c(0,27.5),main = "The number of reTweets per user")
  
  #!!!Dealing with dates !!!
  par(mar=c(10,4,4,2))
  barplot(table(weekdays(more$created))[c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")],las=2,main = " ",xlab = " ",ylab = " ")
  #if you wanna sort data on dates
  sort(table(weekdays(MoreUser$created)),decreasing = T)
  
  #Simple wordcloud with Tweets
  words = strsplit(textcloud$text," ")
  words = unlist(words)
  words = table(words)
  wordcloud(names(words),words,colors=rainbow(8),min.freq = 50)
  
  #StatusSource of Platform
  platform = gsub("<[^<>]*>","",Tweets2Use$statusSource)
  platform1 = sort(table(platform),decreasing = T)
  par(mar=c(10,4,4,2))
  barplot(platform1,las=2,xlim = c(0,20),main = "Top20 Platform",ylab = "Number",xlab = "Platform")
  
  ##################################################################
  #scraping tweets TEXT to make wordcloud
  sentence = Tweets2Use$text
  sentence2 = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ",sentence)
  sentence3 = gsub("@\\w+", " ", sentence2)
  sentence4 = gsub("(?!')[[:punct:]]", "", sentence3,perl = T)
  sentence5 = gsub("[[:cntrl:]]", "", sentence4)
  sentence6 = gsub("[[:digit:]]", "", sentence5)
  sentence7 = iconv(sentence6, "UTF-8", "ASCII", sub = "")
  sentence8 = tolower(sentence7)
  sentence9 = gsub("http\\w*", "", sentence8)
  sentence10 = gsub("[ \t]{2,}", " ", sentence9)
  sentence11 = gsub("^\\s+|\\s+$", "", sentence10)
  word.list = strsplit(sentence11, " ")
  words = unlist(word.list)
  words = words[!words %in% tm::stopwords(kind = "english")]
  words = table(words)
  wordcloud(names(words),words,colors = rainbow(8),min.freq = 100,random.order = F)
  ###################################################################
  
  
  --------------
  #Tweets Time#
  --------------
  #Time Zone
  grep(OlsonNames(),pattern = "Montrea|Tokyo|Dubai",value = T)
  #Change time to its time zone on Tweets created
  tweets$created = as.POSIXct(as.integer(tweets$created), origin = "1970-01-01", tz = "Europe/London")
  
  #Trunc time into 24hr
  TimeNum = as.numeric(difftime(tweets$created, trunc(tweets$created,"days"), tz = "Europe/London", "hours"))
  hist(TimeNum,main = "Hist of Time Density",xlab="Hours",freq = F)
  lines(density(TimeNum),col=2,lwd=2)
  
  #Counting Character
  countchar = nchar(tweets$text)
  
  #Use dplyr package to calculate the monthly/weekly average of 
  #positive words and negative words in the tweets
  tweets1$created = as.Date(cut(tweets1$created,"weeks"))
  by_weeks = group_by(tweets1,tweets1$created)
  summary_stat = summarise(by_weeks, Avg.Pos.Words = mean(positive_word_count),Avg.Neg.Words = mean(negative_word_count))
  
  #Create a wordcloud to show @mentions/#hashtags!!!
  x = unlist(strsplit(tweets$text," "))
  y = grep("@\\w+",x,value = T)
  z = table(y)
  wordcloud(names(z),z,colors=rainbow(8),random.order = F)
  mtext("WordCloud",side = 3,line = 0) # Make a title for wordcloud
  
  
  
  
  