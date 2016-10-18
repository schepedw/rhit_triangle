class ActiveOfficersController < ApplicationController
  before_action :require_admin_role

  def edit
    @officer = ActiveOfficer.find(params[:id])
    @members = Member.all
  end

  def update
    @officer = ActiveOfficer.find(params[:id])
    @officer.update(member_id: params[:active_officer][:member_id])
    @officer.reload
  end
end
