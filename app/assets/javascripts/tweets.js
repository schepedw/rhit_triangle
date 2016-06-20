$(function(){
  $.ajax({url: '/tweets.json', success: populateTweets});
})

function populateTweets(tweets){
  for(var i = 0; i < tweets.length; i++){
    tweet = tweets[i];
    tweetRow = $('#tweet-' + i);
    tweetImgContainer = tweetRow.find('.img-container');
    tweetImgContainer.append($("<img src='"+ tweet.user.profile_image_uri + "'class='author-pic'>"));
    tweetRow.find('.user-name').html(tweet.user.name + ' · ');
    tweetRow.find('.user-handle').html(' @' + tweet.user.screen_name + ' · ');
    tweetRow.find('.tweet-created-at').html(' ' + tweet.created_at);
    tweetRow.find('.tweet-content').html(tweet.text);
    tweetRow.find('.tweet-link a').attr('href', tweet.url);
  }
}
