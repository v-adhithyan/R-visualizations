library(ggplot2)
library(plyr)
library(gganimate)
library(ggrepel)
rm(list = ls())

world <- map_data("world", )
world <- world[world$region != "Antarctica",]

gg <- ggplot()
gg <- gg + geom_map(data=world, map=world,
                    aes(x=long, y=lat, map_id=region),
                    color="#99d8c9", fill="#2ca25f", alpha=1/4)

data = read.csv("data/data.csv")
gg <- gg + geom_point(data = data, aes(x=long, y=lat, color = Rank, frame=year, cumulative = TRUE), size = 2.5)

geom_jitter(width = 0.1) +labs(title = "Happiness across world (darker more happier in")+theme_void()
gg <- gg +  geom_jitter(width = 0.1)

gganimate(gg, "output.gif")