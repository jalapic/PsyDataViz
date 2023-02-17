library(babynames)

library(ggtext)


baby_flights_by_year <- babynames %>%
  filter(sex=="M") %>%
  filter(year>=2012, year<=2017) %>%
  select(year, state = name, flights = n) %>%
  group_by(year, state) %>%
  summarise(flights = sum(flights))

baby_rank_by_year <- baby_flights_by_year %>%
  group_by(year) %>%
  mutate(
    rank = row_number(desc(flights))
  ) %>%
  ungroup() %>%
  arrange(rank, year)

max_rank <- 12

baby_todays_top <- baby_rank_by_year %>%
  filter(year == 2017, rank <= max_rank) %>%
  pull(state)

baby_todays_top

baby_colors <- c(
  "Liam" = "#012169",
  "Noah" = "#DD0000",
  "William" = "#F1BF00",
  "James" = "#002654",
  "Logan" = "#008C45",
  "Benjamin" = "#C8102E",
  "Mason" = "#BA0C2F",
  "Elijah" = "#F36C21",
  "Oliver" = "#046A38",
  "Jacob" = "#DA291C",
  "Lucas" = "#DC143C",
  "Michael" = "#001489"
)

description_color <- "grey40"



baby_rank_by_year %>%
  filter(state %in% baby_todays_top) %>%
  ggplot(aes(year, rank, col = state)) +
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
    title = "Popularity of Selected Boy's Names in USA 2012-2017"
  )+
  geom_text(
    data = baby_rank_by_year %>%
    filter(year == 2012, state %in% baby_todays_top),
    aes(label = state),
    hjust = 1,
    nudge_x = -0.1,
    fontface = "bold"
  ) +
  geom_text(
    data = baby_rank_by_year %>%
      filter(year == 2017, state %in% baby_todays_top),
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












