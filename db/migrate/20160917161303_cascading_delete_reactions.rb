class CascadingDeleteReactions < ActiveRecord::Migration
  def change
    remove_foreign_key :reactions, column: :member_id
    remove_foreign_key :reactions, column: :post_id
    execute('ALTER TABLE reactions ADD CONSTRAINT member_id_fk FOREIGN KEY (member_id) REFERENCES members (member_id) ON DELETE CASCADE')
    execute('ALTER TABLE reactions ADD CONSTRAINT post_id_fk FOREIGN KEY (post_id) REFERENCES posts (post_id) ON DELETE CASCADE')
  end
end
