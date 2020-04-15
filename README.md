# Nunavut Wildlife Cooperative Research Unit
### A repository to help maintain to visual consistency across all products.


## Colour Palette

The primary colour used for figures is reds. Differentiating between primary objects with the figure is done by using varying lightness as seen below. Greys are used to plot objects with less emphasis, or highlight regions within the figure. Blues are included in the palette just in case the range of reds is insufficient, or it's necessary to include another colour (not the preference).

Colour palettes are loaded by sourcing the ```nuwcru_fx.R``` script, and colours are chosen from darkest (```red[1]```) to lightest (```red[5]```):

```
source("scripts/nuwcru_fx.R")

df %>%
 ggplot() +
   geom_point(aes(x = x, y = y), colour = red[1]) +
   theme_nuwcru()
```

![](https://github.com/nuwcru/nuwcru_vis/blob/master/images/example_reds.jpg) 



![](https://github.com/nuwcru/nuwcru_vis/blob/master/images/palette.png) 




## Example Logo

See general purpose logo below. For presentations and documents, see additional options in the image folder.\
\
\
\
![](https://github.com/nuwcru/nuwcru_vis/blob/master/images/logo2.jpg)

