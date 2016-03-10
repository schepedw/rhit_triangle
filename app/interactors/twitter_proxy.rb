=begin
binding.pry
class TwitterProxy
  class << self
    def load_tweets(opts = {})
      [{
        author: 'ur_mom',
        retweets: 3,
        favorites: 5,
        content: 'lol jk chek out this shit tho'
      },{
        author: 'hi my names Thomas',
        retweets: 15,
        favorites: 30,
        content: 'tweet twoot twaat twiit twuut'
      }]
    end
  end
end
=end
