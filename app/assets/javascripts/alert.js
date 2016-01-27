$(document).on('click', '.alert button.close-button', function() {
  $('.alert').remove();
  $('.messages').append('<div class="spacer"></div>');
});
