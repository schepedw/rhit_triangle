class AlumniController < ApplicationController
  before_action :set_admin_flag

  def index
    @alumni_officers = AlumniOfficer.all
  end

  private

  def set_admin_flag
    @admin_flag = current_member.present? && current_member.has_role?(:admin)
  end
end
