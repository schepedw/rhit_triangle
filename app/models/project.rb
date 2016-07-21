class Project < ActiveRecord::Base
  belongs_to :project_status
  has_many :donations

  def pictures
    Dir.glob(File.join('uploads', 'project_images', title.downcase.gsub(' ', '_'), '*'))
  end

  def capital_progress
    donations.sum(:amount)
  end
end
