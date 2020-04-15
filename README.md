# Nunavut Wildlife Cooperative Research Unit
### A source package to house useful functions in one location

To install:

```
devtools::install_github("nuwcru/nuwcru")
library(nuwcru)
```

Package contents evolve pretty quickly, so it's a good idea to reinstall (```devtools::install_github("nuwcru/nuwcru")```) before each use.


## Colour Palette

The primary colour used for figures is red. Differentiating between objects within the figure is completed by varying the lightness as seen below. Greys are used to plot objects with less emphasis, or highlight regions within the figure. Blues are included in the palette for unique scenarios when the range of reds is insufficient, or it's necessary to include another colour (not the preference).

Colour palettes are loaded by sourcing the ```nuwcru_fx.R``` script, and colours are ordered in vectors from darkest (```red[1]```) to lightest (```red[5]```):

```
library(nuwcru)

df %>%
 ggplot() +
   geom_point(aes(x = x, y = y), colour = red[1]) +
   theme_nuwcru()
```

![](https://github.com/nuwcru/nuwcru/blob/master/images/example_reds.jpg) 

<p align="center">
  <img width="600" src="https://github.com/nuwcru/nuwcru/blob/master/images/palette.png">
</p>

<br/>
<br/>
<br/>
<br/>

## Logos

See general purpose logo below. For presentations and documents, see additional options in the image folder.<br/>
<br/>

<p align="center">
  <img width="350" src="https://github.com/nuwcru/nuwcru/blob/master/images/logo2.jpg">
</p>
