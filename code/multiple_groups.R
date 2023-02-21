### Creating Random Data

values1 <- abs(rnorm(n=40, mean = 8, sd = 5))
values2 <- abs(rnorm(n=40, mean = 10, sd = 6))
values3 <- abs(rnorm(n=40, mean = 14.5, sd = 9))

subjs <- paste0("s",1:120)
group <- sample(LETTERS[1:4],120,T)
condition <- rep(c("low","medium","high"),each=40)

df <- data.frame(values=c(values1,values2,values3),
                 subjs,group,condition)

df
head(df)
str(df)
table(group)

fit <- lm(data=df,values ~ group*condition)
summary(fit)
df

ggplot(df, aes(x=group,y=values,fill=condition))+
  geom_boxplot()

write.csv(df,"data_raw/viralload.csv",row.names = F)
