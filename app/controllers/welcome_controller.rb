class WelcomeController < ApplicationController
  def index
    @officers = ActiveOfficer.all
  end
end
