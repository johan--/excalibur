$(document).on("ready page:change", function()  {
  // Hide div
  $("#start-filter").css("display","none");
  $("#court-filter").css("display","none");

  // Add onclick handler to checkbox w/ class 'show start-filter'
  $("#show-start-filter").click(function(){
    if ($("#show-start-filter").is(":checked")) {
      // Show the hidden div
      $("#start-filter").show("fast");
    }
    else {
      // Otherwise, hide it
      $("#start-filter").hide("fast");
    }
  });

  $("#show-court-filter").click(function(){
    if ($("#show-court-filter").is(":checked")) {
      // Show the hidden div
      $("#court-filter").show("fast");
    }
    else {
      // Otherwise, hide it
      $("#court-filter").hide("fast");
    }
  });  
});