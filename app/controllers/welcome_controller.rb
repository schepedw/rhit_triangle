class WelcomeController < ApplicationController
  before_action :set_admin_flag

  def index
    @active_roles = Role.where(role_type: 'active')
  end
end
