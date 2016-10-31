class Project < ActiveRecord::Base
  around_update :move_pictures
  after_destroy :delete_pictures
  after_save    :save_pictures
  belongs_to :project_status
  has_many :donations
  attr_writer :pictures
  delegate :status, to: :project_status

  def pictures
    files = Dir.glob(File.join(picture_dir, '*'))
    files.map { |f| f.gsub(/^#{File.join(Rails.root, 'public')}/, '') }
  end

  def picture_dir(title = self.title)
    File.join(Rails.root, 'public', 'uploads', 'project_images', title.downcase.gsub(%r{['\s\x00\/\\:\*\?\"<>\|]}, '_'))
  end

  def move_pictures
    return(yield) unless changes[:title].present?
    old_picture_dir = picture_dir(changes[:title].first)
    yield
    new_picture_dir = picture_dir
    FileUtils.mv(old_picture_dir, new_picture_dir)
  end

  def delete_pictures
    FileUtils.rm_rf(picture_dir)
  end

  def capital_progress
    donations.to_a.sum(&:amount)
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

  def save_pictures
    return unless @pictures.present?
    FileUtils.mkdir_p picture_dir
    @pictures.each do |picture|
      FileUtils.move picture.tempfile.path, picture_dir
    end
  end
end
