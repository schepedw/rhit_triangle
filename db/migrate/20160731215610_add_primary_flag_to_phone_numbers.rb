class AddPrimaryFlagToPhoneNumbers < ActiveRecord::Migration
  def up
    add_column :phone_numbers, :primary, :boolean, default: true
    add_column :phone_numbers, :created_at, :timestamp
    add_column :phone_numbers, :updated_at, :timestamp
  end
end
