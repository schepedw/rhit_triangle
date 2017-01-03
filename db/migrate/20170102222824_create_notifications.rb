class CreateNotifications < ActiveRecord::Migration
  def up
    create_table :notifications, primary_key: :notification_id do |t|
      t.integer :post_id, null: false
      t.integer :recipient_id, null: false
      t.integer :notifier_id, null: false
      t.boolean :acknowledged, null: false, default: false
    end

    add_foreign_key 'notifications', 'members', column: :notifier_id, primary_key: 'member_id', name: 'recipient_member_fk'
    add_foreign_key 'notifications', 'members', column: :recipient_id, primary_key: 'member_id', name: 'notifier_member_fk'
  end

  def down
    drop_table :notifications
  end
end
