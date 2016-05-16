TwitterProxy = Twitter::REST::Client.new do |config|
  config.consumer_key        = AppConfig.twitter_creds.consumer_key
  config.consumer_secret     = AppConfig.twitter_creds.consumer_secret
  config.access_token        = AppConfig.twitter_creds.access_token
  config.access_token_secret = AppConfig.twitter_creds.access_token_secret
end
TwitterProxy.user('RHIT_Triangle')
