class MembersController < ApplicationController
  before_action :authenticate_member!, :require_admin_role

  def index

  end
end
