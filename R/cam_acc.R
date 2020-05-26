
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(dplyr)
library(stringr)
library(lubridate)





# function to assess false negative accuracy - not likelihood threshold specified
cam_acc <- function(a, b){
  filt_model_results <- x %>% filter(year == a & site == b)
  filt_provisioning  <- y %>% filter(year == a & site == b)
  if (nrow(filt_provisioning) > 0 & nrow(filt_model_results) > 0){
    datalist <- list()
    for(i in 1 : nrow(filt_provisioning)){
      datalist[[i]] <- subset(filt_model_results, date >= filt_provisioning$Start[i] & date <= filt_provisioning$End[i])
    }
    comp <- do.call(rbind, datalist)

    comp$sum_adults <- rowSums(comp[c("Class1", "Class2", "Class3", "Class4", "Class5", "Class6")] == "adult", na.rm = TRUE)

    comp$sum_adults <- ifelse(comp$sum_adults > 1, 1, comp$sum_adults)
    n <- nrow(comp)
    correct <- sum(comp$sum_adults)
    accuracy <- correct / n

    my_list <- data.frame("site"= b,
                          "year"      = a,
                          "n"         = n,
                          "correct"  = correct,
                          "accuracy" = round(accuracy*100,2))
    my_list
  }
  else {
    paste("Site", b, "cannot be matched", sep = " ")
    empty_list <- data.frame("site"= b,
                             "year"= a,
                             "n"   = NA,
                             "correct"  = NA,
                             "accuracy" = NA)
    empty_list
  }

}
