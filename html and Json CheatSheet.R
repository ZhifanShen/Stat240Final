
-------
#html#
-------

#Html setup
course_url = "https://www.sfu.ca/outlines.html?2019/spring/stat/240/d100"
course_page = readLines(course_url)

#Using `grep` to extract values can get us close but is not always specific enough and is limited to just one line.

index = grep("<h1 id=\"name\">", course_page,ignore.case = TRUE)

trimws(gsub("<[^>]*>", "", h1_tags[2]))


#Everything up to -
(step1 = gsub(".*\\-", "", number1))

#paste things together
step1 = paste(course_page[(indexstart + 1):(indexend - 1)], collapse = "")


-----------
#HTML Table
-----------
library(rvest)
library(RCurl)
#HTML Table: Use read_html
rl2use = "https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films"
marvel_page = read_html(url2use)

#Then use html_nodes to read "table"
marvel_table = html_nodes(marvel_page,"table")

#Use Length to check how many table you got
length(marvel_table)

#Next,read tables in order
ratingTable = html_table(marvel_table[[9]])
BudgetTable = html_table(marvel_table[[8]],fill = TRUE)

#Merge table and delete certain rows
MCU_movies =merge(boxoffice[c(-1,-2),1:8],critResponse, by.x="V1", by.y="V1" )

#When you change info from the table you get,rem to as.character
Film = as.character(MCU_movies$Film)
BO_Worldwide  = as.numeric(gsub("[[:punct:]]", "", as.character(MCU_movies$BO_Worldwide)))

#Moving Avg ksmooth
lines(ksmooth(x=x, y=y, bandwidth = 2))



#Rename certain colname
colname(df)[3] = "NAME"



------
#JSON#
------
#If you read a JSON from file NOT URL
result = fromJSON("textname.json")

library(jsonlite)
courseURL = "http://www.sfu.ca/bin/wcm/courseoutlines?2019/spring/stat/240/d100" 
course_info = fromJSON(courseURL) 
class(course_info) # find the data format & check if the API broke
attributes(course_info) # Use this to find out what the main pieces of the JSON contain
length(course_info)
names(course_info)
lapply(course_info,class)  #very useful tool to check internal info











