$(window).load(function() {
  $("#driver-location").click(function(event) {
    event.preventDefault();
    findLoc();
  });
});

var driverLoc;
function findLoc() {
  navigator.geolocation.getCurrentPosition(function (position) {
    driverLoc = {lat: position.coords.latitude, lon: position.coords.longitude}
    makeAjaxRequestLoc(driverLoc)
  });
};

var makeAjaxRequestLoc = function(location) {
  debugger;
  var request = $.ajax({
    method: 'GET',
    url: 'http://ip-api.com/json/?fields=24816'
  });

  request.success(function(data) {
  });
};
