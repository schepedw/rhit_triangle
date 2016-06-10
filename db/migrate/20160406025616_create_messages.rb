class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages, primary_key: :message_id do |t|
      t.integer :sender_contact_id,  null: false
      t.string :direction, null: false
      t.string :subject, null: false
      t.text :content, null: false
      t.text :attachments
      t.timestamps null: false
    end
    add_foreign_key :messages, :contacts, column: :sender_contact_id, primary_key: :contact_id
  end

  def down
    drop_table :messages
  end
end
