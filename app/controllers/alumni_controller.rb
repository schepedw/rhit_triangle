class AlumniController < ApplicationController
  def index
    @alumni_officers = AlumniOfficer.all
  end
end
