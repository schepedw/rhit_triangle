class CascadingDeletePosts < ActiveRecord::Migration
  def change
    execute('ALTER TABLE posts DROP CONSTRAINT parent_id_fk')
    execute('ALTER TABLE posts ADD CONSTRAINT parent_id_fk FOREIGN KEY (parent_id) REFERENCES posts (post_id) ON DELETE CASCADE')
  end
end
