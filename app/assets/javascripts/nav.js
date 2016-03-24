$(function(){
  $('.dropdown').on('show.bs.dropdown', function () {
    backdrop = $('<div class="dropdown-backdrop">')
    $('.dropdown').append(backdrop);
  })
});
