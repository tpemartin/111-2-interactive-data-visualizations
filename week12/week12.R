ubike_data <-
    (jsonlite::fromJSON("ubikeAPI.json"))[["data-url"]] |>
    jsonlite::fromJSON()
ubike_data
dplyr::glimpse(ubike_data)
{
    library(leaflet)
    leaflet(ubike_data) %>%
        addTiles() %>%
        addMarkers(~lng, ~lat)
}
