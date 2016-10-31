class RolesController < ApplicationController
  before_action :set_admin_flag, :require_admin_role

  def edit
    @role = Role.find(params[:id])
    @members = Member.all # TODO: scope this on age eligibility
    render "#{@role.role_type}_officers/edit"
  end

  def update
    @role = Role.where(role_params.except(:member_id)).first
    @role.update(role_params.slice(:member_id))
    render "#{@role.role_type}_officers/update"
  end

  private

  def role_params
    params.require(:role).permit(:member_id, :title, :role_type, :id).symbolize_keys
  end
end
