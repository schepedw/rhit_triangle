class CreateMessageBccRecipients < ActiveRecord::Migration
  def up
    create_table :message_bcc_recipients, primary_key: :message_bcc_recipient_id do |t|
      t.integer :message_id, null: false
      t.integer :contact_id, null: false
      t.timestamps null: false
    end
    add_foreign_key :message_bcc_recipients, :contacts, column: :contact_id, primary_key: :contact_id
    add_foreign_key :message_bcc_recipients, :messages, column: :message_id, primary_key: :message_id
  end

  def down
    drop_table :message_bcc_recipients
  end
end
