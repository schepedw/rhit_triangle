class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects, primary_key: :project_id do |t|
      t.string   :title, null: false
      t.text     :description, null: false
      t.integer  :project_status_id, null: false
      t.decimal  :price, precision: 7, scale: 2, null: false
      t.timestamps null: false
    end
    add_foreign_key :projects, :project_statuses, column: :project_status_id, primary_key: :project_status_id
  end

  def down
    drop_table :projects
  end
end
