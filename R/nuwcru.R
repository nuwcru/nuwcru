
# plot themes  --------------------------------------------

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


theme_image <- function(){
  theme_bw() +
    theme(axis.text = element_blank(),
          axis.title =element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.line.x = element_blank(),
          axis.line.y = element_blank(),
          axis.ticks.x = element_blank(),
          axis.ticks.y = element_blank(),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.border = element_rect(colour = "black", size = 1.5),
          plot.title = element_blank(),
          legend.text = element_blank(),
          legend.title = element_blank(),
          #legend.position = c(0.9, 0.9),
          legend.key = element_rect(colour = NA, fill = NA),
          legend.background = element_rect(color = "black",
                                           fill = "transparent",
                                           size = 4, linetype = "blank"))
}


# * Colour Palettes -------------------------------------------------------

red  <- c("#590815", "#A02828", "#B55454", "#D19595", "#F4E1E1")
blue <- c("#0F4363","#275E86","#6B8091","#B3C1C9", "#D4E1E8")
grey <- c("#191919", "#424242", "#5E5E5E", "#7F7F7F", "#9D9D9D","#B9B9B9","#D5D5D5","#E9E9E9")



# calculation functions --------------------------------------------

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


# image class --------------------------------------------



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







