class CreateUnassociatedPicsDir < ActiveRecord::Migration
  def up
    FileUtils.mkdir_p(File.join(Rails.root, 'public/uploads/unassociated_pictures'))
  end

  def down
    FileUtils.rm_rf(File.join(Rails.root, 'public/uploads/unassociated_pictures'))
  end
end
