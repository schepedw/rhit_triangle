class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts, primary_key: :contact_id do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email, null: false
      t.string :dorm
      t.timestamps null: false
    end
  end

  def down
    drop_table :contacts
  end
end
