class CreatePhoneNumber < ActiveRecord::Migration
  def up
    create_table :phone_numbers, primary_key: :phone_number_id do |t|
      t.integer :member_id, null: false
      t.string  :phone_number, null: false
      t.string  :phone_number_type, default: 'mobile'
    end
    add_foreign_key :phone_numbers, :members, column: :member_id, primary_key: :member_id
  end

  def down
    drop_table :phone_numbers
  end
end
