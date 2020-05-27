
list.of.packages <- c("dplyr", "stringr", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dplyr)
library(stringr)
library(lubridate)



# copy Audio files from specific times of the day over to new directory

wav_copy <- function(source = "/Volumes/LACIE/QAM/ARU Recordings/wavs/2015",    # source directory
                      dest   = "/Volumes/LACIE/Wildtrax1 - 1AM-11AM/2015",
                      site = "R1Z1",
                      start = 1,         # start time
                      end   = 11,           # end time
                      create_dir = FALSE
){
# change filnames to dates so they can be subsetted
  files <- list.files(paste0(source, "/", site), ".wav$")

  date <- str_sub(files, 6, -5)
  date <- str_replace_all(date, "_", " ")
  str_sub(date,12,2) <- ":"
  str_sub(date,15,2) <- ":"
  str_sub(date,5,0) <- "/"
  str_sub(date,8,0) <- "/"
  date <- ymd_hms(date)
  hour <- hour(date)
  files <- data.frame(filename = files,
                      date = date,
                      hour = hour)

  str_sub(files$filename, 0, 0) <- paste(source,"/",site,"/", sep = "")

# subset files based on times
  files_up <- files %>% filter(hour > start & hour < end)

# copy subsetted filenames to new directory
  if (create_dir == TRUE) {
    dir_create(paste0(dest, "/", site))
    fs::file_copy(files_up$filename,
              paste0(dest, "/", site))}
  else {
    fs::file_copy(files$filename,
              paste0(dest, "/", site))
              }

  message(paste(length(files_up$filename), "files moved to new directory"))

}

