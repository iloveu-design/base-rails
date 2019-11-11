//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap3-typeahead.min
//= require bootstrap-autocomplete-input
//= require bootstrap-autocomplete-input-init
//= require cocoon
//= require summernote/summernote-bs4.min
//= require summernote-slowalk

$(document).ready(function() {
  window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
    });
  }, 2000);
});