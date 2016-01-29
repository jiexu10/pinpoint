$(document).on("mouseover", function() {
  $('li#cart').off();
  // $('li#account').off();
});

$(document).on("mouseover", "li#cart", function() {
  $('li#cart').addClass('is-active opens-right');
  $('li#cart ul').addClass('js-dropdown-active');
});

$(document).on("mouseleave", "li#cart", function() {
  $('li#cart').removeClass('is-active opens-right');
  $('li#cart ul').removeClass('js-dropdown-active');
});

// $(document).on("mouseover", "li#account", function() {
//   $('li#account').addClass('is-active opens-right');
//   $('li#account ul').addClass('js-dropdown-active');
// });
//
// $(document).on("mouseleave", "li#account", function() {
//   $('li#account').removeClass('is-active opens-right');
//   $('li#account ul').removeClass('js-dropdown-active');
// });
