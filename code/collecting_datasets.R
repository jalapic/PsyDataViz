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
