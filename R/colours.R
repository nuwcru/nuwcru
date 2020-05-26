
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(dplyr)
library(stringr)
library(lubridate)




# colours


# Reds
red1  <- "#620012"
red2  <- "#AD1520"
red3  <- "#C14D51"
red4  <- "#DA9193"
red5  <- "#F7DFE0"

# Blues
blue1 <- "#004366"
blue2 <- "#095E89"
blue3 <- "#668092"
blue4 <- "#AFC0C9"
blue5 <- "#D0E0E8"

# Greys
grey1 <- "#191919"
grey2 <- "#424242"
grey3 <- "#5E5E5E"
grey4 <- "#7F7F7F"
grey5 <- "#9C9C9C"
grey6 <- "#CCCCCC"
grey7 <- "#E0E0E0"
grey8 <- "#EFEFEF"

