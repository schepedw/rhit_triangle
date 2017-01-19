class PostsNotificationFk < ActiveRecord::Migration
  def up
    add_foreign_key :notifications, :posts, column: :post_id, primary_key: :post_id, on_delete: :cascade
  end

  def down
    remove_foreign_key :notifications, :posts
  end
end
