
function prepareBaseMap(currentLocation) {
  if(!leaflet.map){
    // create map without declaration makes map a global object
    leaflet.map = L.map('map').setView(currentLocation, 13);
    // Add different layers to map via sequence of
      // L.{specific layer}.addTo(map)

      // Add map tiles
      L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19
      }).addTo(leaflet.map);
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
  prepareBaseMap(currentLocation);
  
};

function errorCallback(error) {
  console.log(error)

};
