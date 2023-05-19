
//R
// m = leaflet() |> setView(25.05, 121.5, 12)
m = L.map("map").setView([25.05,121.5],13)

//R
// m |> addTiles() -> m
L.tileLayers(
  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",{},{},{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"https://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}
).addToMap(m)

//R
// m %>% addMarkers(lng=121.5, lat=25.05, popup="Taipei") -> m
L.marker(25.05,121.5,{},{},{},{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"Taipei",{},{},{},{},{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},{}).addToMap(m)
