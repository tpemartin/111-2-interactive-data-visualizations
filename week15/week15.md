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


