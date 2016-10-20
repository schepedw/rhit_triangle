class RolesController < ApplicationController
  def edit
    @role = Role.find(params[:id])
    @members = Member.all # TODO: scope this on age eligibility
    render "#{@role.role_type}_officers/edit"
  end
end
