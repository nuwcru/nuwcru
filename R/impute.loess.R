
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(dplyr)
library(stringr)
library(lubridate)




# impute geospatial data using loess

impute.loess <- function(y, x.length = NULL, s = 0.80,smooth.data = FALSE, ...) {
  if(is.null(x.length)) { x.length = length(y) }
  options(warn=-1)
  x <- 1:x.length
  p <- loess(y ~ x, span = s, data.frame(x=x, y=y))
  if(smooth.data == TRUE) {
    y <- predict(p, x)
  } else {
    na.idx <- which( is.na(y) )
    if( length(na.idx) > 1 ) {
      y[na.idx] <- predict(p, data.frame(x=na.idx))
    }
  }
  return(y)
}

