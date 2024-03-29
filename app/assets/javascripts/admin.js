//= require rails-ujs
//= require activestorage
//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require bootstrap3-typeahead.min
//= require bootstrap-autocomplete-input
//= require bootstrap-autocomplete-input-init
//= require cocoon
//= require jquery-ui/widgets/sortable
//= require rails_sortable
//= require summernote/summernote-bs4.min
//= require summernote-image-title
//= require summernote-video-attributes
//= require summernote-slowalk
//= require turbolinks
//= require jquery.blockUI

$(document).ready(function() {
  bsCustomFileInput.init();

  window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
    });
  }, 2000);

  initializeSortable();
});

$(document).on('turbolinks:load', function() {
  initializeSortable();
});

function initializeSortable() {
  $('[data-js-sortable]').railsSortable();
}