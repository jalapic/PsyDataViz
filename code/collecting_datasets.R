### Where datasets came from - acknowledgements

# Diseases
diseases <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")
write.csv(diseases, "data_raw/diseases.csv", row.names=F)
head(diseases)

#Schizophrenia
schz <- season::schz
head(schz)
write.csv(schz,"data_raw/schz.csv", row.names=F)


