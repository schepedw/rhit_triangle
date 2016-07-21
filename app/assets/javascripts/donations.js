var char_based_offset = function(char_count){
  return ({4: 7, 5: 14, 6: 21, 7: 28, 8: 35})[char_count]
}

$(function(){
  $('.project-slider').each(function(){
    progress = $(this).find('.capital-progress');
    total_cost = $(this).find('.total-cost');
    $(this).find('#project-slider').slider({
      value: parseInt(progress.html().replace('$', '')),
      max: parseInt(total_cost.html().replace('$', '')),
      disabled: true,
      range: "min"
    });
    progress_width = parseInt($(this).find('.ui-slider-range').css('width').replace('px', ''));
    offset = progress_width - char_based_offset(progress.html().length);
    progress.css('left', offset > 0 ? (offset + 'px') : 0 );
  });
  $('.ui-slider-handle').hide();
});
