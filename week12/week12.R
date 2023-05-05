ubikeMap <- list()

urlAPI <- jsonlite::fromJSON("ubikeAPI.json")

# New Taipei City Youbike data
{
    pages <- c(0, 1)
    getNewTaipeiJSON <- function(page) {
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
# Taipei city Youbike data
{
    ubikeMap$data$Taipei <-
        urlAPI$Taipei |>
        jsonlite::fromJSON()
}
# Correct data class
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
# combine data
dplyr::bind_rows(
    ubikeMap$data$Taipei,
    ubikeMap$data$`New Taipei`
) -> ubikeMap$dataMerged

# prepare crosstalk shared data
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
            icon = "fa-crosshairs", title = "Locate Me",
            onClick = JS("function(btn, map){
                   myMap = map;
                   map.locate({setView: true}); }")
        )) -> ubikeMap$leaflet
}
# Google direction
{
    ubikeMap$dataMerged[c("lat", "lng")][500, c("lat", "lng")] |>
        paste0(collapse = ",") -> pin
    currentGPS <- "24.9441075,121.0692864"
    glue::glue(
        "https://www.google.com/maps/dir/{currentGPS}/{pin}/@{pin},15z/data=!4m5!4m4!1m1!4e1!1m0!3e2"
    ) |>
        browseURL()
    "https://www.google.com/maps/dir/24.9441075,121.0692864/24.9456645,121.3694314/@24.9456371,121.3691364,20z/data=!4m5!4m4!1m1!4e1!1m0!3e2"
}
saveRDS(ubikeMap, "ubikeMap.rds")
