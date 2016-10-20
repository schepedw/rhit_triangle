class Role < ActiveRecord::Base
  belongs_to :member

  validates :role_type, inclusion: { in: ['alumni', 'active'] }, allow_nil: true

  scopify
end
