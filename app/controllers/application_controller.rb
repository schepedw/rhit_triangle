class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::RedirectBackError do
    redirect_to root_path
  end

  private

  def set_admin_flag
    @admin_flag = (current_member.present? && current_member.admin?)
  end

  def require_admin_role
    redirect_to :back unless set_admin_flag
  end
end
