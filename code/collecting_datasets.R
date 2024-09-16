### Where datasets came from - acknowledgements

# Diseases
diseases <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")
write.csv(diseases, "data_raw/diseases.csv", row.names=F)
head(diseases)

#Schizophrenia
schz <- season::schz
head(schz)
write.csv(schz,"data_raw/schz.csv", row.names=F)


#EPL bump chart
x <- read.csv("https://raw.githubusercontent.com/jalapic/jalapic.github.io/master/soccer1.csv")
head(x)
library(tidyverse)
x <- x %>% select(team,gameno,rank,finalrank)
write.csv(x, "data_raw/epl.csv", row.names = F)


##LEGO
x<-read.csv("https://raw.githubusercontent.com/Antichthon/lego-sets/master/lego_sets.csv")
head(x)
dim(x)
table(x$theme_name)
table(x$country)

x %>%select(ages, list_price, piece_count,  prod_id,
            review_difficulty, set_name, play_star_rating, star_rating,
            val_star_rating,theme_name,country) -> x

x$theme_name<-gsub("Â®","",x$theme_name)
x$theme_name<-gsub("â„¢","",x$theme_name)

unique(x$theme_name)
write.csv(x, "data_raw/lego.csv", row.names = F)


### Joe Root innings by innings list
library(rvest)


## Root
url <- "https://stats.espncricinfo.com/ci/engine/player/303669.html?class=1;template=results;type=batting;view=innings"
page <- read_html(url)
table <- page %>%
  html_nodes(".engineTable") %>%
  html_table(fill = TRUE)
innings_df <- data.frame(table[[4]])
innings_df$name <- "Root"

## Bradman
url2<-"https://stats.espncricinfo.com/ci/engine/player/4188.html?class=1;template=results;type=batting;view=innings"
page2 <- read_html(url2)
table2 <- page2 %>%
  html_nodes(".engineTable") %>%
  html_table(fill = TRUE)
innings_df2 <- data.frame(table2[[4]])
innings_df2$name <- "Bradman"

## Tendulkar
url3<-"https://stats.espncricinfo.com/ci/engine/player/35320.html?class=1;template=results;type=batting;view=innings"
page3 <- read_html(url3)
table3 <- page3 %>%
  html_nodes(".engineTable") %>%
  html_table(fill = TRUE)
innings_df3 <- data.frame(table3[[4]])
innings_df3$name <- "Tendulkar"

head(innings_df)

df <- rbind(
  innings_df[,c(1:9,11:13,15)],
  innings_df2[,c(1:9,11:13,15)],
  innings_df3[,c(1:9,11:13,15)]
)

df$Opposition <- gsub("v ", "", df$Opposition)  
df$Runs <- gsub("\\*", "", df$Runs)  
df$Runs<-as.numeric(df$Runs)
df<-df[!is.na(df$Runs),]
head(df)
str(df)
df$Mins<-as.numeric(df$Mins)
df$BF<-as.numeric(df$BF)
df$X4s<-as.numeric(df$X4s)
df$X6s<-as.numeric(df$X6s)
df$SR<-as.numeric(df$SR)

df$Runs
#write.csv(df, "data_raw/cricket.csv", row.names = F)
table(df$Dismissal)
table(df$Pos)


## Spotify
x <- read.csv("https://raw.githubusercontent.com/devyanikal/Spotify-Analysis/main/Spotify%20(1).csv")
head(x)
write.csv(x, "data_raw/spotify.csv", row.names = F)


## Trip Adviser
x<-read.csv("https://raw.githubusercontent.com/geshem14/TripAdviser_DS/master/main_task.csv")
write.csv(head(x[,1:8]),"data_raw/restaurant.csv", row.names = F)

## crime in boston
x<-read.csv("https://raw.githubusercontent.com/MaGu1997/Boston-Crime-Analysis/master/crime.csv")
head(x)
write.csv(x, "data_raw/bostoncrime.csv", row.names = F)
