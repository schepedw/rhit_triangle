class DropContactsTable < ActiveRecord::Migration
  def down
    drop_table :message_recipients
    drop_table :contacts
    execute('ALTER TABLE messages DROP CONSTRAINT fk_rails_7d377cfeb9')
  end
end
