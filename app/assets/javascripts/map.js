$(window).load(function() {
  loadScript();
});

var latLng, map;
function initMap(restaurantLoc) {
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
    debugger;
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
    '&callback=makeAjaxRequestRestaurant';
  document.body.appendChild(script);
};

var getRestLatLng = function(data) {
  debugger;  
}
var makeAjaxRequestRestaurant = function(getRestLatLng) {
  var pathname = window.location.pathname;
  orderId = pathname.match(/\/orders\/(\d+)/)[1];
  var request = $.ajax({
    method: 'GET',
    url: '/api/v1/restaurants/' + orderId
  });

  request.success(function(data) {
    getRestLatLng(data);
  });

  request.error(function(data) {
    console.log("didn't work");
  });
};
