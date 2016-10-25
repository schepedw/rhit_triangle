class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::RedirectBackError do
    redirect_to root_path
  end

  private

  def set_admin_flag
    @admin_flag = (current_member.present? && Role.all.pluck(:member_id).include?(current_member.id))
  end

  def require_admin_role
    redirect_to :back unless set_admin_flag
  end
end
