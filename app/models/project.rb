class Project < ActiveRecord::Base
  around_update :move_pictures, :update_sorting
  after_destroy :delete_pictures, :update_sorting
  after_create  :save_pictures
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

  def update_sorting
    self.sort_val = 10_000 if project_status_id == ProjectStatus.find_by(status: 'Complete')
    return(yield) unless changes[:sort_val].present?
    self.class.shift_sorting_between(*changes[:sort_val])
    yield
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

  def self.shift_sorting_between(start, finish)
    operator = start > finish ? '+' : '-'
    start, finish = [start, finish].sort
    connection.execute(
      "
      UPDATE projects SET sort_val = sort_val #{operator} 1
      WHERE sort_val >= #{start} and sort_val <= #{finish}
      "
    )
  end

  private

  def save_pictures
    FileUtils.mkdir_p picture_dir
    return unless @pictures.present?
    Array(@pictures).each do |picture|
      FileUtils.mv(File.join(Rails.root, 'public', picture), picture_dir)
    end
  end
end
