class CreateAddresses < ActiveRecord::Migration
  def up
    create_table :addresses, primary_key: :address_id do |t|
      t.integer :member_id
      t.string  :street_line_1, null: false
      t.string  :street_line_2
      t.string  :city,     null: false
      t.string  :state,    null: false
      t.string  :zip_code, null: false
    end
    add_foreign_key :addresses, :members, column: :member_id, primary_key: :member_id
  end

  def down
    drop_table :addresses
  end
end
