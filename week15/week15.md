# econIDV::LeafletTools


```{r}
library(leaflet)
m = leaflet() %>% setView(lng=121.5, lat=25.05, zoom=13) 
m = m |> addTiles()
m = m |> leaflet::addCircleMarkers(lng=121.5, lat=25.05)
m
```

```{r, include=FALSE}
m$x$calls
# leaflet object widget 
m |> econIDV::LeafletTools() -> lf

lf$calls[[1]]() |> clipr::write_clip()
lf$calls[[2]]()
# translate all m$x$calls element to js
# clipr::write_clip() puts all character vector in your clipboard
lf$allCalls() |> clipr::write_clip()
```

# ubikeDashboard

## Google Map direction

https://www.google.com/maps/dir/24.9475016,121.3745515/@24.9464946,121.3716058,17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x34681c0a444c22c3:0x7c9771cca8fa4362!2m2!1d121.37326!2d24.945553!3e1?entry=ttu

```
https://www.google.com/maps/dir/{destination}/@{currentLocation},17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x34681c0a444c22c3:0x7c9771cca8fa4362!2m2!1d121.37326!2d24.945553!3e1?entry=ttu
```
```
