class AlumniController < ApplicationController
  def show
    @alumni_officers = AppConfig.alumni_officers
  end
end
