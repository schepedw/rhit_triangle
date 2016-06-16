class WelcomeController < ApplicationController
  def index
    @tweets = TwitterProxy.user_timeline[0..4]
  rescue Twitter::Error
    @tweets = [] #TODO - make a pseudo object that says 'error' or smn
  ensure
    @officers = AppConfig.officers
  end
end
