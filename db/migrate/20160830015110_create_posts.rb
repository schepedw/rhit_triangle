class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts, primary_key: :post_id do |t|
      t.text         :content, null: false
      t.integer      :author_id, null: false
      t.integer      :parent_id
      t.integer      :channel_id, index: true, null: false
      t.integer      :depth, null: false
      t.timestamps   null: false
    end
    execute("ALTER TABLE posts ADD CONSTRAINT author_id_fk FOREIGN KEY (author_id) REFERENCES members (member_id)")
    execute("ALTER TABLE posts ADD CONSTRAINT parent_id_fk FOREIGN KEY (parent_id) REFERENCES posts (post_id)")
    execute("ALTER TABLE posts ADD CONSTRAINT channel_id_fk FOREIGN KEY (channel_id) REFERENCES channels (channel_id)")
    execute("ALTER TABLE posts ADD CONSTRAINT positive_depth CHECK (depth >= 0)")
  end

  def down
    drop_table :posts
  end
end
