class AlumniOfficersController < ApplicationController
  before_action :authenticate_member!, :require_admin_role, :set_admin_flag

  def edit
    @members = Member.all
    @officer = AlumniOfficer.find(params[:id])
  end

  def update
    @position = AlumniOfficer.find(params[:id])
    @position.update(position_params)
    @position.member.update(member_params.slice(:profile_picture))
  end

  private

  def position_params
    params.require(:alumni_officer).permit(:member_id, :bio)
  end

  def member_params
    params.require(:alumni_officer).permit(:member_id, :profile_picture)
  end
end
