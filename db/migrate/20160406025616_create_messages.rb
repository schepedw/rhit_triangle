class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, primary_key: :message_id do |t|
      t.integer :sender_contact_id,  null: false
      t.string :direction, null: false
      t.string :subject, null: false
      t.text :content, null: false
      t.text :attachments
    end
    add_foreign_key :messages, :contacts, column: :sender_contact_id, primary_key: :contact_id
  end
end
