$(document).ready(function() {
  checkOrderPage();
});

var checkOrderPage = function() {
  setInterval(function() {
    if ($("span.order-status").length) {
      makeAjaxRequestStatus();
    };
  }, 10000);
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
    if ($("span.order-status").text() != data.status_name) {
      $("span.order-status").css("color","#cf2f00");
      $("span.order-status").text(data.status_name);
      var timeoutTextColor = setTimeout(function() {
        $("span.order-status").css("color","#3adb76");
      }, 2000);
    }
  });

  request.error(function() {
    console.log("status didn't work");
  });
};
