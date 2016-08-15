class AddTitleToMembers < ActiveRecord::Migration
  def up
    add_column :members, :title, :string
  end

  def down
    remove_column :members, :title
  end
end
