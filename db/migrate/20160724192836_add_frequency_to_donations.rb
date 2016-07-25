class AddFrequencyToDonations < ActiveRecord::Migration
  def up
    add_column :donations, :frequency, :string, null: false
  end

  def down
    remove_column :donations, :frequency
  end
end
