$(document).ready(function() {
  $("#driver-location").click(function(event) {
    event.preventDefault();
    var driverId = event.target.id
    createInterval(findLoc, driverId, 15000);
  });
  $("#clear-location").click(function(event) {
    event.preventDefault();
    var driverId = event.target.id
    if (intervalFunc) {
      clearInterval(intervalFunc);
    };
    ajaxClearLoc(driverId);
  });
});

var intervalFunc;
var createInterval = function(locationFunc, driverId, interval) {
  intervalFunc = setInterval(function() {
    locationFunc(driverId);
  }, interval);
};

var findLoc = function(driverId) {
  navigator.geolocation.getCurrentPosition(function (position) {
    var driverLoc = {lat: position.coords.latitude, lng: position.coords.longitude};
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
    $('.spacer').remove();
    $('.messages').html(
      '<div class="warning callout flash">Sending Location...</div>');
  });

  request.error(function(data) {
    console.log("driver location send didn't work");
  });
};

var ajaxClearLoc = function(driverId) {
  var request = $.ajax({
    method: 'PATCH',
    data: { request: 'clear' },
    url: '/api/v1/users/' + driverId
  });

  request.success(function() {
    console.log("driver location cleared");
    $('.flash').remove();
    $('.messages').append('<div class="spacer"></div>');
  });

  request.error(function() {
    console.log("clear didn't work");
  });
};
