class AddMessageToDonations < ActiveRecord::Migration
  def up
    add_column :donations, :message, :text
  end

  def down
    remove_column :donations, :message
  end
end
