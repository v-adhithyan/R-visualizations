library(ggplot2)
library(gridExtra)
library(ggrepel)
library(grid)

data = read.csv("2015.csv")

p1 <- ggplot(data = data, aes(x = HI, y = PCI, color = Region)) 
p2 <- p1 +   geom_smooth(aes(group = 1), formula = y ~ log(x), method = "lm", color = "blue")

p3 <- p2 +geom_point(size = 4, shape = 1) + geom_point(size = 3.5, shape = 1) + geom_point(size = 3, shape = 1)

p4 <- p3 +  scale_x_continuous(name = "Happiness Index") + 
      scale_y_continuous(name = "Per Capita Income") 

pointsToLabel = c("India", "China", "Bhutan", "Nepal", "Pakistan",
                  "Switzerland", "New Zealand", "Australia", "Israel",
                  "United States", "United Arab Emirates", "United Kingdom",
                  "Singapore", "Germany", "Qatar", "Thailand", "Saudi Arabia",
                  "Taiwan", "South Korea", "Italy", "Peru",
                  "Malaysia", "Russia", "Vietnam", "Bangladesh", "South Africa",
                  "Egypt", "Uganda", "Cambodia", "Afghanisthan"
                  )

p5 <- p4 + geom_text_repel(aes(label=Country), color = "gray20", data = subset(data, Country %in% pointsToLabel), force = 10)
p5 <- p5 + ggtitle ("Happiness Index and Per capita Income")
p6 <- p5 + theme_minimal() +
  theme(text = element_text(color = "gray20"),
        legend.position = c("top"),
        legend.direction = "horizontal",
        legend.justification = 0.1,
        legend.text = element_text(size = 11, color = "gray10"),
        axis.text = element_text(face = "italic"),
        axis.title.x = element_text(vjust = -1), # move title away from axis
        axis.title.y = element_text(vjust = 2), # move away for axis
        axis.ticks.y = element_blank(), # element_blank() is how we remove elements
        )
mR2 <- summary(lm(PCI ~ log(HI), data = data))$r.squared

png(file = "econScatter10.png", width = 800, height = 600)
p6 
grid.text("Sources: Kaggle",
          x = .02, y = .03,
          just = "left",
          draw = TRUE)
grid.segments(x0 = 0.81, x1 = 0.825,
              y0 = 0.90, y1 = 0.90,
              gp = gpar(col = "red"),
              draw = TRUE)
grid.text(paste0("R² = ",
                 as.integer(mR2*100),
                 "%"),
          x = 0.835, y = 0.85,
          gp = gpar(col = "gray20"),
          draw = TRUE,
          just = "left")

dev.off()


#flip <- p2 + coord_flip()

#grid.arrange(p2, flip)