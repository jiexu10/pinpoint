$(document).ready(function() {
  checkOrderPage();
});

var checkOrderPage = function() {
  setInterval(function() {
    if ($("span.order-status").length) {
      makeAjaxRequestStatus();
    };
  }, 15000);
};

var makeAjaxRequestStatus = function() {
  var pathname = window.location.pathname;
  var orderId = pathname.match(/\/orders\/(\d+)/)[1];
  var request = $.ajax({
    method: 'GET',
    data: { request: 'user' },
    url: '/api/v1/orders/' + orderId
  });

  request.success(function(data) {
    console.log("status sent" + data.status_name);
    $("span.order-status").text(data.status_name);
  });

  request.error(function(data) {
    console.log("status didn't work");
  });
};
