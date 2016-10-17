class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_admin_role
    redirect_to :back unless current_member && current_member.has_role?(:admin)
  end

  rescue_from ActionController::RedirectBackError do
    redirect_to root_path
  end
end
