$(window).load(function() {
  loadScript();
});

var latLng, map, userMarker, restLatLng, driverPathLine;
var driverPathArray = [];

function initMap(restaurantLoc) {
  restLatLng = restaurantLoc

  navigator.geolocation.getCurrentPosition(function (position) {
    latLng = new google.maps.LatLng(
        position.coords.latitude, position.coords.longitude);

    map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: latLng,
      zoom: 15
    });

    userMarker = new google.maps.Marker({
      position: latLng,
      map: map,
      title: "User Location"
    });

    addRestMarker();

    setInterval(function() {
      pollDriverLoc();
    }, 15000);
  });
};

var addRestMarker = function() {
  var restMarker = new google.maps.Marker({
    position: restLatLng,
    map: map,
    title: "Restaurant Location"
  });

  restMarker.setMap(map)
};

var pollDriverLoc = function() {
  ajaxRequestDriver(drawMapLine);
};

var ajaxRequestDriver = function(drawMapLine) {
  var pathname = window.location.pathname;
  var orderId = pathname.match(/\/orders\/(\d+)/)[1];
  var request = $.ajax({
    method: 'GET',
    data: {request: 'driver'},
    url: '/api/v1/orders/' + orderId
  });

  request.success(function(data) {
    console.log("driver location received");
    drawMapLine(data);
  });

  request.error(function() {
    console.log("driver didn't work");
  });
};

var drawMapLine = function(data) {
  if (driverPathLine) {
    driverPathLine.setMap(null);
  }
  driverPathArray.push(data);
  driverPathLine = new google.maps.Polyline({
    path: driverPathArray,
    geodesic: true,
    strokeColor: '#0000FF',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  driverPathLine.setMap(map);
};

function loadScript() {
	console.log("map loading ...");
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
    '&key=AIzaSyAb8CnEhJE0HkNTD0YYGRmQBtpkEN9Aux8'+
    '&libraries=drawing' +
    '&callback=getRestData';
  document.body.appendChild(script);
};

var getRestData = function() {
  ajaxRequestRestaurant(initMap);
};

var ajaxRequestRestaurant = function(initMap) {
  var pathname = window.location.pathname;
  var orderId;
  if (pathname.match(/\/orders\/(\d+)/)) {
    orderId = pathname.match(/\/orders\/(\d+)/)[1];
  };

  if (orderId) {
    var request = $.ajax({
      method: 'GET',
      data: { request: 'restaurant' },
      url: '/api/v1/orders/' + orderId
    });

    request.success(function(data) {
      initMap(data);
    });

    request.error(function() {
      console.log("rest didn't work");
    });
  };
};
