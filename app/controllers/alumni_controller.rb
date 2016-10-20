class AlumniController < ApplicationController
  before_action :set_admin_flag

  def index
    @alumni_roles = Role.where(role_type: 'alumni')
  end
end
