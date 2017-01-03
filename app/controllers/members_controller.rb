class MembersController < ApplicationController
  before_action :authenticate_member!

  def index
    respond_to do |format|
      format.json do
        render json: { suggestions: Member.where("screen_name like '%#{scrubbed_screen_name}%'").pluck(:screen_name) }
      end
    end
  end

  def edit
    @owner_flag = params[:member_id].nil? || current_member.id == params[:member_id]
  end

  def update
    current_member.update(member_params)
    redirect_to '/', flash: { notice: 'Profile Successfully Updated' }
  end

  private

  def scrubbed_screen_name
    params[:screen_name].to_s.gsub(/[^\w\.]/, '').downcase
  end

  def member_params
    params.require(:member).permit(
      *%i[email phone_number first_name last_name middle_name initiation_year graduation_year hometown bio]
    )
  end
end
