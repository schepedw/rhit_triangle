TwitterProxy = Twitter::REST::Client.new do |config|
  config.consumer_key        = AppConfig.twitter.consumer_key
  config.consumer_secret     = AppConfig.twitter.consumer_secret
  config.access_token        = AppConfig.twitter.access_token
  config.access_token_secret = AppConfig.twitter.access_token_secret
end
#TwitterProxy.user('RHIT_Triangle')
