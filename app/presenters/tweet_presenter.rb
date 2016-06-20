class TweetPresenter
  attr_reader :tweets
  def initialize(*tweets)
    @tweets = tweets
  end

  def as_json(_opts = {})
    tweets.map do |tweet|
      {
        user: {
          profile_image_uri: tweet.user.profile_image_uri.to_s,
          name: tweet.user.name,
          screen_name: tweet.user.screen_name
        },
        created_at: tweet.created_at.strftime('%b %-d'),
        text: Twitter::Autolink.auto_link(tweet.text).html_safe,
        url: tweet.url.to_s
      }
    end
  end
end
