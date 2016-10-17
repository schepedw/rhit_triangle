class WelcomeController < ApplicationController
  def index
    @officers = ActiveOfficer.all.includes(:member)
  end
end
