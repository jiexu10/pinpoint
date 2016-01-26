$(window).load(function() {
  $("#driver-location").click(function(event) {
    event.preventDefault();
    var driverId = event.target.id
    findLoc(driverId);
  });
});

function findLoc(driverId) {
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
    console.log("driver location sent")
  });
};
