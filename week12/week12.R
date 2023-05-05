ubike_data <-
    (jsonlite::fromJSON("ubikeAPI.json"))[["data-url"]] |>
    jsonlite::fromJSON()
ubike_data
dplyr::glimpse(ubike_data)

ubikeMap = list()
{
    library(leaflet)

    leaflet(ubike_data) |>
        setView(121.5288805, 25.0418781, zoom = 14) |>
        addProviderTiles(
            providers$CartoDB.Positron
        ) |>
        addCircleMarkers(
            lng = ~lng, lat = ~lat,
            radius = 4,
            # color = ~pal(type),
            stroke = FALSE, fillOpacity = 0.7
        ) -> ubikeMap$leaflet 
}

saveRDS(ubikeMap, "ubikeMap.rds")
