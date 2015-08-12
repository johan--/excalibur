$(document).on("ready page:change", function()  {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $('.attachinary-input').attachinary();
})