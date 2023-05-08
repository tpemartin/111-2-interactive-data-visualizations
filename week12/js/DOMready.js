document.addEventListener("DOMContentLoaded", function(event) {
    //do work

    //prepare default map
    currentLocation = [25.05, 121.5]
    prepareBaseMap(currentLocation);
    
    //get current location and update map
    navigator.geolocation
        .getCurrentPosition(successCallback, errorCallback)
        


})
