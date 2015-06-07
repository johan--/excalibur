$(document).on("ready page:change", function()  {

  // Add onclick handler to radio 
  $("#firm_pref_dp_state_off").click(function(){
    if ($("#firm_pref_dp_state_off").is(":checked")) {
      // Show the hidden div
      $('#firm_pref_dp_percent').attr('disabled', true);
      $('#firm_pref_dp_deadline').attr('disabled', true);
      // $("#trading-help").show("fast");
      // $("#service-help").hide("fast");
      // $("#manufacture-help").hide("fast");
    }
    else {
      // Otherwise, hide it
      $('#firm_pref_dp_percent').attr('disabled', false);
    }
  });

  $("#firm_pref_dp_state_on").click(function(){
    if ($("#firm_pref_dp_state_on").is(":checked")) {
      // Show the hidden div
      $('#firm_pref_dp_percent').attr('disabled', false);
      $('#firm_pref_dp_deadline').attr('disabled', false);
      // $("#trading-help").show("fast");
      // $("#service-help").hide("fast");
      // $("#manufacture-help").hide("fast");
    }
    else {
      // Otherwise, hide it
      $('#firm_pref_dp_percent').attr('disabled', true);
    }
  });
});