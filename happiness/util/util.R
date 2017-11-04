library(ggplot2)
library(plyr)
library(gganimate)
library(ggrepel)
library(dplyr)

rm(list = ls())
d_2015 <- read.csv("n2015.csv")
d_2016 <- read.csv("n2016.csv")
d_2017 <- read.csv("n2017.csv")

d_2015 <- cbind(year = 2015, d_2015)
head(d_2015)
d_2016 <- cbind(year = 2016, d_2016)
d_2017 <- cbind(year = 2017, d_2017)

data <- rbind.fill(d_2015, d_2016, d_2017)
head(data, 10)
write.csv(file = "com.csv", data)

d2015 = read.csv("2015.csv")
d2016 = read.csv("2016.csv")
d2017 = read.csv("2017.csv")

location = read.csv("location.csv")

merge_and_write <- function(filename, data1, data2) {
  merged_data <- data1 %>% left_join(data2, by = c("Country" = "Country")) %>% filter(is.na(Rank) == FALSE)
  write.csv(file=filename, merged_data)
}

merge_and_write("n2015.csv", d2015, location)
merge_and_write("n2016.csv", d2016, location)
merge_and_write("n2017.csv", d2017, location)