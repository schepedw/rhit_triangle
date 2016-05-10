class WelcomeController < ApplicationController
  def index
    @tweets = TwitterProxy.user_timeline[0..4]
    @officers = AppConfig.officers
  end
end
