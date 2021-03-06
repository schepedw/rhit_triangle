class Member < ActiveRecord::Base
  has_one :role
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :phone_numbers
  has_many :notifications, foreign_key: :recipient_id
  after_save :update_primary_phone, :update_profile_picture

  attr_writer :phone_number, :profile_picture

  def phone_number
    return @phone_number if @phone_number.present?
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

  def pictures
    [profile_picture].compact
  end

  def has_role?(title, role_type) # rubocop:disable Style/PredicateName
    role.try(:title) == title && role.try(:role_type) == role_type
  end

  def add_role(title, role_type)
    Role.create(member_id: id, title: title, role_type: role_type)
  end

  def admin?
    Role.all.pluck(:member_id).include?(id)
  end

  def remove_role(title, role_type)
    return false unless has_role?(title, role_type)
    role.destroy
  end

  def add_pictures_from_io(upload_stream)
    upload_stream.map do |uploaded_io|
      File.join(picture_dir, uploaded_io.original_filename).tap do |file|
        File.open(file, 'wb') do |f|
          f.write(uploaded_io.read)
        end
      end
    end
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
    return unless @phone_number.present?
    phone_numbers.update_all(primary: false)
    PhoneNumber.create!(member_id: id, phone_number: @phone_number.gsub(/[^0-9]/, ''), primary: true)
  end
end
