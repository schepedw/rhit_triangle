class DonationsController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: { data: Project.find(params[:project_id]).donations.map(&:attributes_with_donor_name)}}
    end
  end

  def new
    @project = Project.find(params[:project_id])
    @current_member = current_member
  end

  def create
    @member = current_member || Member.find_by_email(member_params[:email]) || Member.create!(member_params)
    @member.update!(member_params)
    @donation = Donation.create!(donation_params.symbolize_keys.merge(member_id: @member.id))
  end

  private

  def member_params
    {password: AppConfig.default_password}.merge(params.require(:member)).symbolize_keys
  end

  def donation_params
    params.require(:donation).merge(project_id: params.require(:project_id))
  end
end
