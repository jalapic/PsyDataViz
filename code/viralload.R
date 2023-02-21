
library(tidyverse)

df <- read.csv("data_raw/viralload.csv")
head(df)


df.sum <- df %>%
  group_by(group, condition) %>%
  summarise(
    sd = sd(values),
    mean = mean(values)
  )
df.sum

library(ggpubr)

df.sum$condition <- factor(df.sum$condition, levels=c("low","medium","high"))

ggplot(df.sum, aes(x = group, y = mean, color=condition)) +
  geom_errorbar(
    aes(ymin = mean-sd, 
        ymax = mean+sd),
    position = position_dodge(0.3), 
    width = 0.2,
    linewidth = 1
  ) +
  geom_point(size=2,
             position = position_dodge(0.3)) +
  scale_color_manual(values = c("#bacddd", "#E7B800","#bb3300")) +
  theme_classic() +
  coord_flip() +
  ylab("Group") +
  xlab("Viral Load") +
  geom_signif(xmin = c(1,1.1,2,2.1,3),
              xmax = c(1.1,0.9,2.1,1.9,2.9),
              y_position = c(32,33.5,23,24.5,19.5),
              annotation = c("***", "***","*", "**","**"),
              tip_length = 0.01,
              color='black',
              vjust=0.6)

dfa  <- df %>% filter(group=="A")
dfb  <- df %>% filter(group=="B")
dfc  <- df %>% filter(group=="C")
dfd  <- df %>% filter(group=="D")

TukeyHSD(aov(data=dfd, values~condition))
TukeyHSD(aov(data=dfc, values~condition))
TukeyHSD(aov(data=dfb, values~condition))
TukeyHSD(aov(data=dfa, values~condition))
