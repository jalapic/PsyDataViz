library(babynames)
library(ggtext)
library(tidyverse)
library(ggbump)

baby_year <- babynames %>%
  filter(sex=="M") %>%
  filter(year>=2012, year<=2017) %>%
  select(year, name, total = n) %>%
  group_by(year) %>%
  mutate(
    rank = row_number(desc(total))
  ) %>%
  ungroup() %>%
  arrange(rank, year)

baby_year


baby_top <- baby_year %>%
  filter(year == 2017, rank <= 12) %>%
  pull(name)

baby_top

#baby_colors <- c("#006ddb","#004949","#b66dff","#6db6ff","#920000","#924900","#db6d00","#000000","#b6dbff" ,"#009292","#ff6db6","#490092")

baby_colors <- pals::tol(12)
names(baby_colors)<-baby_top

p<-baby_year %>%
  filter(name %in% baby_top) %>%
  ggplot(aes(year, rank, col = name)) +
  geom_point(size = 2) +
  geom_bump(size = 1) +
  scale_y_reverse(position = "right", breaks = seq(80, -2, -2)) +
  scale_color_manual(values = baby_colors) +
  coord_cartesian(xlim = c(2010, 2017.5), ylim = c(80, -1.25), expand = F) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "floralwhite", color = "floralwhite"),
    plot.title = element_text(
      margin = margin(t = 3, b = 4, unit = "mm"),
      hjust = 0.5
    ),
    plot.margin = margin(0,1,1.5,1.2, "cm")
  ) +
  labs(
    x = "",
    y = "",
    title = "Popularity of Selected Boys' Names in USA 2012-2017"
  )+
  geom_text(
    data = baby_year %>%
    filter(year == 2012, name %in% baby_top),
    aes(label = name),
    hjust = 1,
    nudge_x = -0.1,
    fontface = "bold"
  ) +
  geom_text(
    data = baby_year %>%
      filter(year == 2017, name %in% baby_top),
    aes(label = rank),
    hjust = 0,
    nudge_x = 0.1,
    size = 4,
    fontface = "bold"
  ) +
  annotate(
    "text",
    x = c(2011.75, 2016.75),
    y = c(-0.75, -0.75),
    label = c(2012, 2017),
    hjust = c(0, 0),
    vjust = 1,
    size = 4,
    fontface = "bold"
  ) 

p
ggsave("img/babybump.png", p, height=12, width=6)










