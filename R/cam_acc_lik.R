
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(dplyr)
library(stringr)
library(lubridate)





# function to determine accuracy of specified likelihood thresholds


cam_acc_lik <- function(a, b, L){
  filt_model_results <- x %>% filter(year == a & site == b)
  filt_provisioning  <- y %>% filter(year == a & site == b)
  if (nrow(filt_provisioning) > 0 & nrow(filt_model_results) > 0){
    datalist <- list()
    for(i in 1 : nrow(filt_provisioning)){
      datalist[[i]] <- subset(filt_model_results, date >= filt_provisioning$Start[i] & date <= filt_provisioning$End[i])
    }
    comp_uf <- do.call(rbind, datalist)
    comp <- filter(comp_uf, Class1 == "adult" & Percent1 > L |
                     Class2 == "adult"& Percent2 > L |
                     Class3 == "adult"& Percent3 > L |
                     Class4 == "adult"& Percent4 > L |
                     Class5 == "adult"& Percent5 > L |
                     Class6 == "adult"& Percent6 > L)


    comp$sum_adults <- rowSums(comp[c("Class1", "Class2", "Class3", "Class4", "Class5", "Class6")] == "adult", na.rm = TRUE)

    comp$sum_adults <- ifelse(comp$sum_adults > 1, 1, comp$sum_adults)
    n <- nrow(comp_uf)
    correct <- sum(comp$sum_adults)
    accuracy <- correct / n

    my_list <- data.frame("site"       = b,
                          "year"       = a,
                          "n"          = n,
                          "likelihood" = L,
                          "correct"  = correct,
                          "accuracy" = round(accuracy*100,2))
    my_list
  }
  else {
    paste("Site", b, "cannot be matched", sep = " ")
    empty_list <- data.frame("site"= b,
                             "year"= a,
                             "n"   = NA,
                             "likelihood" = L,
                             "correct"  = NA,
                             "accuracy" = NA)
    empty_list
  }

}

