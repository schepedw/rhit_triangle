class AddTimestampsToNotifications < ActiveRecord::Migration
  def up
    add_column(:notifications, :created_at, :datetime)
    add_column(:notifications, :updated_at, :datetime)
    Notification.update_all(created_at: Time.now, updated_at: Time.now)
    change_column_null(:notifications, :created_at, false)
    change_column_null(:notifications, :updated_at, false)
  end

  def down
    remove_column(:notifications, :created_at, :datetime)
    remove_column(:notifications, :updated_at, :datetime)
  end
end
