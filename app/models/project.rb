class Project < ActiveRecord::Base
  around_update :move_pictures
  after_destroy :delete_pictures
  belongs_to :project_status
  has_many :donations

  def pictures
    files = Dir.glob(File.join(picture_dir, '*'))
    files.map { |f| f.gsub(/^#{File.join(Rails.root, 'public')}/, '') }
  end

  def picture_dir(title = self.title)
    File.join(Rails.root, 'public', 'uploads', 'project_images', title.downcase.gsub(' ', '_'))
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

  def status
    project_status.status
  end

  def capital_progress
    donations.to_a.sum(&:amount)
  end
end
