class CreateDonations < ActiveRecord::Migration
  def up
    create_table :donations, primary_key: :donation_id do |t|
      t.integer :member_id, null: false
      t.integer :project_id, null: false
      t.decimal :amount, precision: 7, scale: 2, null: false
      t.string  :visibility, null: false, default: 'private'
      t.timestamps null: false
    end

    add_foreign_key :donations, :members, column: :member_id, primary_key: :member_id
    add_foreign_key :donations, :projects, column: :project_id, primary_key: :project_id
  end

  def down
    drop_table :donations
  end
end
