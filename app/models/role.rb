class Role < ActiveRecord::Base
  belongs_to :member

  validates :role_type, inclusion: { in: ['alumni', 'active'] }, allow_nil: true

  scopify

  def self.sort(roles)
    roles.sort_by(&:sort_val)
  end

  def sort_val
    AppConfig.officers["#{role_type}_officers".to_sym].index(title)
  end
end
