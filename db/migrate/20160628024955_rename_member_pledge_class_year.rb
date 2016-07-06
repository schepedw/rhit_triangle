class RenameMemberPledgeClassYear < ActiveRecord::Migration
  def up
    rename_column :members, :pledge_class_year, :initiation_year
  end

  def down
    rename_column :members, :initiation_year, :pledge_class_year
  end
end
