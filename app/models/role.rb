class Role < ActiveRecord::Base
  has_and_belongs_to_many :members, join_table: :members_roles

  belongs_to :resource, polymorphic: true, required: false

  validates :resource_type, inclusion: { in: Rolify.resource_types }, allow_nil: true

  scopify
end
