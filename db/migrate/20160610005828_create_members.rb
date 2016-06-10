class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members, primary_key: :member_id do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :hometown
      t.string :email, null: false
      t.integer :graduation_year
      t.integer :pledge_class_year
      t.integer :pledge_father_id
      t.timestamps null: false
    end
    add_foreign_key :members, :members, column: :pledge_father_id, primary_key: :member_id
  end

  def down
    drop_table :members
  end
end
