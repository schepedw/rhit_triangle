# TODO: rm after release of https://github.com/schepedw/rhit_triangle/pull/13
class ActiveOfficer < ActiveRecord::Base
  belongs_to :member
  default_scope { includes(:member) }
  around_update :update_admin_role

  private

  def update_admin_role
    return yield unless changes[:member_id].present?
    old_member_id = changes[:member_id].first
    yield
    unless ActiveOfficer.find_by_member_id(old_member_id) || AlumniOfficer.find_by_member_id(old_member_id)
      Member.find(old_member_id).remove_role(:admin)
    end
    Member.find(member_id).add_role(:admin)
  end
end
