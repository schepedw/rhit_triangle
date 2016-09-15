class CreateReactions < ActiveRecord::Migration
  def up
    create_table :reactions, primary_key: :reaction_id do |t|
      t.string :reaction_text, null: false
      t.integer :member_id, null: false, index: true
      t.integer :post_id, null: false, index: true
    end

    add_foreign_key :reactions, :posts, column: :post_id, primary_key: :post_id
    add_foreign_key :reactions, :members, column: :member_id, primary_key: :member_id
  end

  def down
    drop_table :reactions
  end
end
