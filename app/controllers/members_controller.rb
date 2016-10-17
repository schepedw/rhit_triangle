class MembersController < ApplicationController
  before_action :authenticate_member!

  def edit
  end

  def update
    current_member.update(member_params)
    redirect_to '/', flash: { notice: 'Profile Successfully Updated' }
  end

  private

  def member_params
    params.require(:member).permit(
      *%i[email phone_number first_name last_name middle_name initiation_year graduation_year hometown]
    )
  end
end
