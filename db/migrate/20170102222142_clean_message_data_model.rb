class CleanMessageDataModel < ActiveRecord::Migration
  def change
    drop_table :message_bcc_recipients
    drop_table :message_cc_recipients

    add_column :message_recipients, :bcc, :boolean, default: false, null: false
    add_column :message_recipients, :cc, :boolean, default: false, null: false
    add_column :message_recipients, :owner_type, :string, null: false
    add_column :message_recipients, :notification_id, :integer

    #execute('ALTER TABLE messages DROP CONSTRAINT fk_rails_7d377cfeb9')
    rename_column :messages, :sender_contact_id, :from_id
  end
end
