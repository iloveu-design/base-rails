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

$(document).ready(function() {
  $('[data-provider="summernote"]').each(function() {
    $(this).summernote({lang: 'ko-KR', height: 300});
  });
});