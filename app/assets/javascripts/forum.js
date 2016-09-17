var textAreaKeys = {};
$(function(){
  $('.channel-title').click(function(){
    $('.current-channel-container').addClass('loading');
    $('img.loading-gif').removeClass('hide');
  })
  $('.new-post textarea').keyup(function (e) {
    delete textAreaKeys[e.which];
  });
  $('.new-post textarea').keydown(function (e) {
    textAreaKeys[e.which] = true;
  });

  $('.posts-container').animate({ scrollTop: $('.posts-container').prop('scrollHeight')}, 500);
  bindNewPostKeyListener();
  bindEditPostKeyListener();
});

var bindEditPostKeyListener = function(){
  $('.edit-post-content').on({
    keydown: function(e){
      if(e.which == 13) { //enter
        $(this).parent('form').submit();
      }}
  });
}

var bindNewPostKeyListener = function(){
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
}

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

var editPost = function(elem) {
  elem.find('.post-content').hide();
  editForm = $('.edit-post-container');
  editForm.find('#content').val(elem.find('.post-content').text());
  postID = elem.parent().parent().data('post-id')
  channelID = editForm.find('#channel_id').val();
  editForm.find('#post_id').val(postID);
  editForm.find('form').attr('action', '/forum/channels/' + channelID + '/posts/' + postID);
  elem.find('.post-metadata').after(editForm)
  editForm.removeClass('hide');
}

var removeCrudFormsFromPost = function(postID) {
  postElem = $('[data-post-id="' + postID + '"]');
  newReply = postElem.find('.new-reply');
  if (newReply.length != 0){
    $('.current-channel-container').append(newReply);
    newReply.addClass('hide');
  }
  editForm = postElem.find('.edit-post-container');
  if (editForm.length != 0){
    $('.current-channel-container').append(editForm);
    editForm.addClass('hide');
  }
}
