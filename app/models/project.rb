class Project < ActiveRecord::Base
  belongs_to :project_status
  has_many :donations

  def pictures
    files = Dir.glob(File.join(Rails.root, 'public', 'uploads', 'project_images', title.downcase.gsub(' ', '_'), '*'))
    files.map { |f| f.gsub(/^#{File.join(Rails.root, 'public')}/, '') }
  end

  def capital_progress
    donations.to_a.sum(&:amount)
  end
end
