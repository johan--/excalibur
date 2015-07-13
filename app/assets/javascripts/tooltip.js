$(document).on("ready page:change", function()  {
  $('[data-toggle="tooltip"]').tooltip()
  $('.input-row #post_topics_list, .input-row #post_tags_list').select2({tags:[]})
})