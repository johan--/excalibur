$(window).scroll(function() {
  if ($(document).scrollTop() > 500) {
    $('nav').addClass('shrink');
  } else {
    $('nav').removeClass('shrink');
  }
});