class AlumniController < ApplicationController
  before_action :set_admin_flag

  def index
    @alumni_roles = Role.sort(Role.where(role_type: 'alumni').where.not(title: 'Nerd'))
  end
end
