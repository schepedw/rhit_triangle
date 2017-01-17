class AddToIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :to_id, :integer, null: false
    execute("ALTER TABLE messages ADD CONSTRAINT to_memberfk FOREIGN KEY (to_id) REFERENCES members (member_id)")
    execute("ALTER TABLE messages ADD CONSTRAINT from_memberfk FOREIGN KEY (from_id) REFERENCES members (member_id)")
  end
end
