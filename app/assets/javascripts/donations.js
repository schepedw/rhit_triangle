$(function(){
  $('.project-slider').each(function(){
    progress = $(this).find('#progress').html();
    total_cost = $(this).find('#total-cost').html();
    $(this).find('#project-slider').slider({
      value: parseInt(progress),
      max: parseInt(total_cost),
      disabled: true,
      range: "min"
    })
  });
  $('.ui-slider-handle').hide();
});
