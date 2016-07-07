$(function(){
  $('#image-carousel').bind('slide.bs.carousel', function (e) {
    if (e.direction == 'right')
      $('#info-carousel').carousel('prev')
    else
      $('#info-carousel').carousel('next')
  });
});
