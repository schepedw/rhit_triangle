class ActiveOfficer < ActiveRecord::Base
  belongs_to :member
  default_scope { includes(:member) }
  around_update :update_admin_role

  private

  def update_admin_role
    return yield unless changes[:member_id].present?
    old_member_id = changes[:member_id].first
    yield
    Member.find(old_member_id).remove_role(:admin)
    Member.find(member_id).add_role(:admin)
  end
end
