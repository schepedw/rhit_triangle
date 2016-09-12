
var textAreaKeys = {};
$(function(){
  $('.new-post textarea').keyup(function (e) {
    delete textAreaKeys[e.which];
  });
  $('.new-post textarea').keydown(function (e) {
    textAreaKeys[e.which] = true;
  });

  $('.posts-container').animate({ scrollTop: $('.posts-container').prop('scrollHeight')}, 500);
  $('.new-post textarea').on({
    input: adjustHeight,
    keydown: function(e){
      if(e.which == 13) { //enter
        if (textAreaKeys[16]) { //shift
          e.preventDefault();
          $(this).val($(this).val() + '\n');
          $(this).trigger('input');
        }else{
          $(this).parent('form').submit();
        }
      }}
  });
});

var adjustHeight = function() {
  // TODO: this isn't perfect
  // TODO: get rid of magic numbers
  $(this).css('height', 'auto');
  $(this).css('height', $(this).prop('scrollHeight') - parseInt($(this).css('padding-bottom')) - parseInt($(this).css('padding-top')) - 1 + 'px');
  newHeight = $(this).css('height');
  var container = $('.posts-container');
  containerHeight = parseInt(container.css('height'));
  newContainerHeight = 'calc(100vh - 168px + 35px - ' + newHeight + ')';
  $('.posts-container').css('height', newContainerHeight);
}

var insertReplyFormAfter = function(elem){
  replyForm = $('.new-reply')
  replyForm.find('#content').val();
  replyForm.find('#parent_id').val(elem.data('reply-to-id'));
  replyForm.insertAfter(elem);
  replyForm.removeClass('hide');
  //TODO: ensure the reply form is visible. A good counterexample of this is replying to the last post on the page
};
