
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(dplyr)
library(stringr)
library(lubridate)

# plotting theme


theme_nuwcru <- function(){
  theme_bw() +
    theme(axis.text = element_text(size = 10),
          axis.title = element_text(size = 14),
          axis.text.x = element_text(angle = -45, hjust = -0.05, colour = "darkgrey"),
          axis.text.y = element_text(colour = "darkgrey"),
          axis.line.x = element_line(color = "darkgrey"),
          axis.line.y = element_line(color = "darkgrey"),
          axis.ticks.x = element_line(colour = "darkgrey"),
          axis.ticks.y = element_line(colour = "darkgrey"),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.border = element_rect(colour = "grey"),
          plot.title = element_text(size = 15, vjust = 1, hjust = 0.5),
          legend.text = element_text(size = 10),
          legend.title = element_blank(),
          #legend.position = c(0.9, 0.9),
          legend.key = element_rect(colour = NA, fill = NA),
          legend.background = element_rect(color = "black",
                                           fill = "transparent",
                                           size = 4, linetype = "blank"))
}

