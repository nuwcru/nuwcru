# Nunavut Wildlife Cooperative Research Unit
### A source package to house useful functions in one location

To install:

```R
devtools::install_github("nuwcru/nuwcru")
library(nuwcru)
```

Package contents evolve pretty quickly, so it's a good idea to reinstall (```devtools::install_github("nuwcru/nuwcru")```) before each use.

#### Contents
[Colour](#Colour) |
[Loess Function](#Impute) |
[file manip](#File) |


## Colour

The primary colour used for figures is red. Differentiating between objects within the figure is completed by varying the lightness as seen below. Greys are used to plot objects with less emphasis, or highlight regions within the figure. Blues are included in the palette for unique scenarios when the range of reds is insufficient, or it's necessary to include another colour (not the preference).

General plotting theme accessed with ```theme_nuwcru()```. You can override the arguments within ```theme_nuwcru()``` by adding another theme argument afterwords. For example:
```R
ggplot() +
  geom_point(data = df, aes(x = x, y = y)) +
  theme_nuwcru() + 
  theme(axis.x.text = element_blank())
```
Consistent facetting formats can be accessed with ```facet_nuwcru()```

Colour palettes are loaded with the source package, and colours are ordered from darkest (```red1```) to lightest (```red5```):

```R
df %>%
 ggplot() +
   geom_line(aes(x = x, y = y1), colour = red1) +
   geom_line(aes(x = x, y = y4), colour = red4) +
   geom_line(aes(x = x, y = y5), colour = red5) +
   theme_nuwcru()
```

<p align="center">
  <img width="600" src="https://github.com/nuwcru/nuwcru/blob/master/images/example_reds.jpg">
</p>


<p align="center">
  <img width="600" src="https://github.com/nuwcru/nuwcru/blob/master/images/palette.png">
</p>

<br/>
<br/>
<br/>
<br/>

## impute.loess()
<br/>
<br/>
<br/>

## file_copy()

This function is used to convert filenames into dates, and copy audio files to new directories depending on the time at which they were recorded. The below example copies all audio files recorded between 1AM and 11AM.

```R
source_dir <- "/Volumes/LACIE/QAM/ARU Recordings/2015/" # copy files from here
dest_dir   <- "/Volumes/NUWCRU_DATA/wildtrax_1"       # to here


# list all the directories in the source_dir
dir <- list.dirs(source_dir, full.names = FALSE)


# 1am < 11am 
for(i in 1:length(dir)){
  file_copy(site   = paste0(dir[i]),
            source = paste(source_dir),    # source location
            dest  = paste(dest_dir),       # destination
            start = 1,                     # grab all recordings between this time (1am)
            end   = 11,                    # until this time (11am)
            create_dir = TRUE)             # move into a new directory
}
```

<br/>
<br/>
<br/>



## Logos

See general purpose logo below. For presentations and documents, see additional options in the image folder.<br/>
<br/>

<p align="center">
  <img width="350" src="https://github.com/nuwcru/nuwcru/blob/master/images/logo2.jpg">
</p>
