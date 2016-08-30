class CreateChannels < ActiveRecord::Migration
  def up
    create_table :channels, primary_key: :channel_id do |t|
      t.text         :subject, null: false
      t.text         :description, null: false
      t.timestamps   null: false
      t.string       :visibility, null: false, default: 'public'
    end

    create_join_table(:channels, :members, table_name: :channel_members) do |t|
      t.index :channel_id
      t.index :member_id
    end

    execute("ALTER TABLE channel_members ADD CONSTRAINT channel_id_fk FOREIGN KEY (channel_id) REFERENCES channels (channel_id)")
    execute("ALTER TABLE channel_members ADD CONSTRAINT member_id_fk FOREIGN KEY (member_id) REFERENCES members (member_id)")
  end

  def down
    drop_table :channel_members
    drop_table :channels
  end
end
