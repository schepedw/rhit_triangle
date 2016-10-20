class Member < ActiveRecord::Base
  rolify
  has_one :role
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :phone_numbers
  after_save :update_primary_phone, :update_profile_picture

  attr_writer :phone_number, :profile_picture

  def phone_number
    number = phone_numbers.find_by(primary: true).try(:phone_number)
    return unless number.present?
    "#{number[0..2]}-#{number[2..4]}-#{number[4..7]}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def picture_dir
    FileUtils.mkdir_p(File.join(Rails.root, 'public', 'uploads', 'member_images', id.to_s))[0]
  end

  def profile_picture
    files = Dir.glob(File.join(picture_dir, '*'))
    return if files.empty?
    files.last.gsub(/^#{File.join(Rails.root, 'public')}/, '')
  end

  private

  def update_profile_picture
    return unless @profile_picture.present?
    FileUtils.rm(profile_picture)
    File.join(picture_dir, id).tap do |file|
      File.open(file, 'wb') do |f|
        f.write(@profile_picture.read)
      end
    end
  end

  def update_primary_phone
    return unless @phone_number.present? && @phone_number != phone_number
    # TODO: test this method.
    phone_numbers.update_all(primary: false)
    PhoneNumber.create!(member_id: id, phone_number: @primary_phone_number.gsub(/[^0-9]/, ''), primary: true)
  end
end
