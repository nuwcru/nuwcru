
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(dplyr)
library(stringr)
library(lubridate)




# plotting theme for facets

facet_nuwcru <- function(){
  theme(
    strip.text.x = element_text(size = 10, color = grey2),
    strip.text.y = element_text(size = 10, color = grey2),
    strip.background = element_rect(color="grey", fill="white"))
}
