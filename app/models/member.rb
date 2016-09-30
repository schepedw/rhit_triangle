class Member < ActiveRecord::Base
  rolify
  has_many :roles, through: :members_roles
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :phone_numbers
  after_save :update_primary_phone

  attr_writer :primary_phone_number

  def primary_phone_number
    phone_numbers.find_by(primary: true)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def update_primary_phone
    return unless @primary_phone_number.present? && @primary_phone_number != primary_phone_number
    # TODO: test this method.
    phone_numbers.update_all(primary: false)
    PhoneNumber.create!(member_id: id, phone_number: @primary_phone_number.gsub(/[^0-9]/, ''), primary: true)
  end
end
