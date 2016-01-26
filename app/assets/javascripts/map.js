$(window).load(function() {
  loadScript();
});

var latLng, map;
function initMap() {
  navigator.geolocation.getCurrentPosition(function (position) {
    latLng = new google.maps.LatLng(
        position.coords.latitude, position.coords.longitude);

    map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: latLng,
      zoom: 15
    });

    marker = new google.maps.Marker({
      position: latLng,
      map: map,
      title: "User Location"
    });

    marker.setMap(map)
  });

};

function loadScript() {
	console.log("map loading ...");
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
    '&key=AIzaSyAb8CnEhJE0HkNTD0YYGRmQBtpkEN9Aux8'+
    '&libraries=drawing'+
    '&callback=initMap';
  document.body.appendChild(script);
};

function getLatLng(result) {
  userLoc = {lat: result.lat, lng: result.lon}
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: userLoc,
    zoom: 14
  });

  marker = new google.maps.Marker({
    position: userLoc,
    map: map,
    title: "User Location"
  });

  marker.setMap(map)
};

var makeAjaxRequestIp = function(getLatLng) {
  var request = $.ajax({
    method: 'GET',
    url: 'http://ip-api.com/json/?fields=24816'
  });

  request.success(function(data) {
    getLatLng(data);
  });
};
