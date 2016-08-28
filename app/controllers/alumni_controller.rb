class AlumniController < ApplicationController
  def index
    @alumni_officers = AppConfig.alumni_officers
  end
end
