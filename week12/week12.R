ubikeMap = list()

urlAPI <- jsonlite::fromJSON("ubikeAPI.json")

{pages = c(0, 1)
getNewTaipeiJSON = function(page){
  urlAPI$`New Taipei` |>
  paste0("&page=", page) |>
  jsonlite::fromJSON()
}
# pages |>
#   purrr::map(getNewTaipeiJSON) -> listNewTaipeiUbike

pages |>
  purrr::map_dfr(
    getNewTaipeiJSON
  ) -> ubikeMap$data$`New Taipei`

}

{ubikeMap$data$Taipei <-
  urlAPI$Taipei |>
  jsonlite::fromJSON()
}
{
  library(magrittr)
  ubikeMap$data$Taipei %<>%
    dplyr::mutate(
      act = as.integer(act)
    )
  ubikeMap$data$`New Taipei` %<>%
    dplyr::mutate(
      tot = as.integer(tot),
      sbi = as.integer(sbi),
      lat = as.double(lat),
      lng = as.double(lng),
      bemp = as.integer(bemp),
      act = as.integer(act)
    )
  dplyr::glimpse(ubikeMap$data$Taipei)
}
dplyr::bind_rows(
  ubikeMap$data$Taipei,
  ubikeMap$data$`New Taipei`
) -> ubikeMap$dataMerged

ubikeMap$sharedData <-
  crosstalk::SharedData$new(ubikeMap$dataMerged)

{
    library(leaflet)

    leaflet(ubikeMap$sharedData) |>
        setView(121.5288805, 25.0418781, zoom = 14) |>
        addProviderTiles(
            providers$CartoDB.Positron
        ) |>
        addCircleMarkers(
            lng = ~lng, lat = ~lat,
            radius = 4,
            # color = ~pal(type),
            stroke = FALSE, fillOpacity = 0.7
        ) |>
      addEasyButton(easyButton(
        icon="fa-crosshairs", title="Locate Me",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))-> ubikeMap$leaflet

}

saveRDS(ubikeMap, "ubikeMap.rds")
