class Role < ActiveRecord::Base
  belongs_to :member

  validates :role_type, inclusion: { in: %w[alumni active admin] }, allow_nil: true

  def self.sort(roles)
    roles.sort_by(&:sort_val)
  end

  def sort_val
    AppConfig.officers["#{role_type}_officers".to_sym].index(title)
  end
end
