
function prepareBaseMap(currentLocation) {
  if(!leaflet.map){
    // create map without declaration makes map a global object
    // equivalent to R's leaflet.map = leaflet() |> setView(...)
    leaflet.map = L.map('map').setView(currentLocation, 13);
    // Add different layers to map via sequence of
      // L.{specific layer}.addTo(map)

      // Add map tiles
      // equivalent to R's leaflet.map |> addTiles(...)
      // L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      //   maxZoom: 19
      // }).addTo(leaflet.map);

      // Use CartoDB.positron
      var CartoDB_Positron = L.tileLayer(
        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
        {"errorTileUrl":"","noWrap":false,"detectRetina":false})
      CartoDB_Positron.addTo(leaflet.map);

//       // Use Esri.NatGeoWorldMap
//       var Esri_NatGeoWorldMap = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}', {
// 	attribution: 'Tiles &copy; Esri &mdash; National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC',
// 	maxZoom: 16
// });
//       Esri_NatGeoWorldMap.addTo(leaflet.map);


  } else {
    leaflet.map.setView(currentLocation, 13);
  }



  // Add marker
  leaflet.currentLocationMarker =
    L.marker(currentLocation).addTo(leaflet.map);
};

function successCallback(position) {
  console.log(position);
  currentLocation = [position.coords.latitude, position.coords.longitude];
  leaflet.currentLocationMarker.remove();

  findCloset5StationFromCurrentLocation(
    {lat: currentLocation[0], lng: currentLocation[1]}
  )
  prepareBaseMap(currentLocation);
  // addCircleMarkers
  args={"lat":25.05,"lng":121.5,"radius":4,"markerOptions":{"radius":4,"interactive":true,"className":"","stroke":false,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.7},"popupContent":"<a href=\"https://www.google.com/maps/@{lat},{lng},15z\">click me<\/a>","popupOptions":{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true}}
  leaflet.min5.forEach(
      addStation
  )


};

function errorCallback(error) {
  console.log(error)

};
function distance(p1, p2) {
  return Math.sqrt(
    Math.pow(p1.lat - p2.lat, 2) + Math.pow(p1.lng - p2.lng, 2)
  );
}
function findCloset5StationFromCurrentLocation(currentLocation){

  // compute distance between two positions
  // var positionX = leaflet.data[0]

  // compute each distance from currentLocation
  var stationDistances = leaflet.data.map(function(x){
    return distance(currentLocation,x);
  });

  // Sort stationDistances
  //var sorted_stationDistances= stationDistances.sort()
  var stations = leaflet.data;
  var min5 = [];
    for(var i=0; i<5; i++){
      var minDistance = Math.min(...stationDistances);
      var minIndex = stationDistances.indexOf(minDistance);
      min5.push(stations[minIndex]);
      stationDistances.splice(minIndex,1);
      stations.splice(minIndex,1);
    }

leaflet.min5 = min5
}
function addStation(station){
    direction = getDirection(station)
    popupContent = getPopupContent(direction)
    latLng = L.latLng(station)
    mk = L.circleMarker(latLng, args.markerOptions)
    mk.bindPopup(
        popupContent,args.popupOptions)
    mk.addTo(leaflet.map)
}

// direction
// https://www.google.com/maps/dir/{destination}/@{currentLocation},17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x34681c0a444c22c3:0x7c9771cca8fa4362!2m2!1d121.37326!2d24.945553!3e1?entry=ttu
function getDirection(station){
    currentMarker = leaflet.currentLocationMarker._latlng
    currentLocation = currentMarker.lat +','+currentMarker.lng
    destination = station.lat+','+station.lng
    direction = `https://www.google.com/maps/dir/${destination}/@${currentLocation},17z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x34681c0a444c22c3:0x7c9771cca8fa4362!2m2!1d121.37326!2d24.945553!3e1?entry=ttu`
  return(direction)
}

function getPopupContent(direction){
       popupContent =  `<a href="${direction}">click me</a>`
    return(popupContent)
}
