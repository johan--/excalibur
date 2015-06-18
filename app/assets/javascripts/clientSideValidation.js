judgeValidateForm($('#new_user'));
function asyncValidateInput(elm) {
  var dfd = new $.Deferred();
  var q = judge.validate(elm,function(element, status, messages){
    if(status == 'valid'){
      element.style.border = '';
      $(element).parent().find('.field_with_errors').remove();
      dfd.resolve();
    }else if(status == 'invalid'){
      element.style.border = '1px solid red';
      $(element).parent().find('.field_with_errors').remove();
      $(element).after('<p class="field_with_errors">' + messages.join(',') + '</p>');
      dfd.reject();
    }
  });
  if(q.validations.length == 0){
    dfd.resolve();
  }
  return dfd;
}
function judgeValidateForm(frm) {
  $(frm).submit(function (e) {
    e.preventDefault();
    $(frm).find('.field_with_errors').remove();
    var defers = [];
    $(frm).find('.form-control').each(function (idx, elm) {
      defers.push(asyncValidateInput(elm));
    });
    $.when.apply($, defers).done(function() {
      $(frm).unbind('submit');
      $(frm).submit();
    });
  });
}