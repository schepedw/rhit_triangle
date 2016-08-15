class CreateInstallments < ActiveRecord::Migration
  def up
    create_table :installments, primary_key: :installment_id do |t|
      t.integer :donation_id, null: false
      t.decimal :amount, precision: 7, scale: 2, null: false
      t.timestamps null: false
    end
    execute('INSERT INTO installments(donation_id, amount, created_at, updated_at) SELECT donation_id, donations.amount, NOW(), NOW() FROM donations')
    remove_column :donations, :amount
    add_foreign_key :installments, :donations, column: :donation_id, primary_key: :donation_id
  end


  def down
    drop_table :installments
  end
end
