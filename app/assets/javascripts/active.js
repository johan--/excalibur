$(document).on("ready page:change", function()  {

  $("#Utama a:contains('Utama')").parent().addClass('active');
  $("#Kontak a:contains('Kontak')").parent().addClass('active');

});