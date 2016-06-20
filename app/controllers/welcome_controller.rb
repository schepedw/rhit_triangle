class WelcomeController < ApplicationController
  def index
    @officers = AppConfig.officers
  end
end
