$(function(){
  $('.officer-title').popover({ });
  $("a[href='#president']").click(function(){
    $('#president .officer-title').popover('toggle');
    setTimeout(function(){ $('#president .officer-title').popover('toggle')}, 3000) ;
  });
});
