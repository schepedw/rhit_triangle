class Project < ActiveRecord::Base
  has_many :pictures
  belongs_to :project_status
end
