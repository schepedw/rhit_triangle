$(function(){
  $('.dropdown').on('show.bs.dropdown', function () {
    backdrop = $('<div class="dropdown-backdrop">')
    $('.dropdown').append(backdrop);
  });
  $('.forum-toggle[data-toggle="popover"]').popover({
    placement: 'bottom',
    title: 'You must be signed in to view the forum',
    animation: false,
    popout: true
  });
  $('.forum-toggle[data-toggle="popover"]').on('shown.bs.popover', function () {
      $('.popover-content').append($('.login-buttons'));
      $('.login-buttons').show();
   })
  $('[data-toggle="popover"]').on('hidden.bs.popover', function () {
    $('.login-buttons').hide();
   })
});
