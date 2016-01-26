$(document).ready(function() {
  $("#driver-location").click(function(event) {
    event.preventDefault();
    var driverId = event.target.id
    createInterval(findLoc, driverId, 15000);
  });
});

var createInterval = function(locationFunc, driverId, interval) {
  setInterval(function() {
    locationFunc(driverId);
  }, interval)
}

var startPolling = function(driverId) {
  setInterval(findLoc(driverId), 5000);
};

var findLoc = function(driverId) {
  navigator.geolocation.getCurrentPosition(function (position) {
    var driverLoc = {lat: position.coords.latitude, lon: position.coords.longitude}
    makeAjaxRequestLoc(driverId, driverLoc)
  });
};

var makeAjaxRequestLoc = function(driverId, driverLoc) {
  var request = $.ajax({
    method: 'PATCH',
    data: driverLoc,
    url: '/api/v1/users/' + driverId
  });

  request.success(function(data) {
    console.log("driver location sent");
  });

  request.error(function(data) {
    console.log("didn't work");
  });
};
