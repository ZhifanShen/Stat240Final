

#1.install packages:
install.packages(c("RSQLite","DBI","sp","rworldmap","rworldxtra","twitteR","wordcloud","rvest","RCurl","dplyr","tm"))
library(tm) # for tweets scraping
#loading files:
load(".Rdata")
#loading csv data frame:
poke=read.csv(file="pokemon_2019.csv",header = TRUE,sep =",")

#Distribution
hist()
lines(density())

#MAKE YOUR PLOT MARGIN LARGER
par(mar=c(10,4,4,2)) 

# Use the "table" commnad in R to count the number of each vehicle make
table()
#If you wanna top 20 after you table it
sort(table(data))
#making barplot of number of stations PER states
# cex.names or cex.axis
barplot(table(station$State),main="NUmber of stations per state",las=2,cex.names = 0.5)

------------------------------------------------------------------------------------------------------------------------------------------------

------
#SQL#
------
#loading SQL database:
dbcon = dbConnect(SQLite(), dbname = "stat240MT1.sqlite")
#list tables in the SQL database
dbListTables(dbcon)
#get variables name of dataset
names(dbReadTable(dbcon, ""))
#Get the data frame
dbReadTable(dbcon,"citiesP")
#INNER JOIN under conditions
sql= "SELECT *or (certain cols) FROM  INNER JOIN   ON  .  =  . WHERE   > "
df = dbGetQuery(dbcon,sql)
#worldmap for canada
worldmap = getMap(resolution = "high")
NrthAm = worldmap[which(worldmap$REGION == "North America"), ]
plot(NrthAm, col = "white", bg = "lightblue", xlim = c(-140, -55), ylim = c(55, 60))
points(map$Longitude,map$Latitude,col="red",cex= .5)
# %symbols
sql4 = "SELECT * FROM tickets WHERE violation_description LIKE '%parking%'"
#make 2 sets of plots in one graph
par(mfrow=c(2,1))
#Using boxplot to do density
boxplot(popden$Population__2006 ~ popden$Prov_acr,las=2)
#makeing a horizontal line
abline( h = )
#table info
query_table_info = "PRAGMA table_info(' ')"
dbGetQuery(dbcon,query_table_info)
#Run Query don't return the results:
QueryOut = dbSendQuery(dbcon,sql)
dbFetch(QueryOut, num or -1)
#Order by
sql = "SELECT DISTINCT name FROM Vanpoke ORDER BY name DESC"
#If you want to select several value using WHERE
sql3 = "SELECT DISTINCT moveset FROM Vanpoke WHERE name IN ('Hitmonchan','Lickitung','Nidoqueen','Primeape','Sharpedo','Victreebel') ORDER BY moveset"

#Create VIEW table into SQL database
mov_avg="CREATE VIEW tot_meds AS SELECT Edition,Count(Edition) AS TotalNumber FROM Olymp_meds GROUP BY Edition"
dbSendQuery(dbcon, mov_avg)
#Drop VIEW table
dbSendQuery(dbcon,"drop view tot_meds")

#Moving Average: You should have Edition and TotalnNumber columns
check=
"SELECT * FROM tot_meds AS t,
(SELECT t1.Edition, AVG(t2.TotalNumber) AS mavg
FROM tot_meds AS t1, tot_meds AS t2
WHERE t2.Edition BETWEEN (t1.Edition-4) AND (t1.Edition+4)
GROUP BY t1.Edition) sq WHERE (t.Edition = sq.Edition)"
movingAvg=dbGetQuery(dbcon, check)

#Get Median and percentiles
getmedian = "SELECT TotalNumber AS Median FROM Can_tot_meds
ORDER BY TotalNumber LIMIT 1 OFFSET (SELECT COUNT(TotalNumber)
FROM Can_tot_meds) /2"
(out = dbGetQuery(con, getmedian))



