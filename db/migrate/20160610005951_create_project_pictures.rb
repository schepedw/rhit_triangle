class CreateProjectPictures < ActiveRecord::Migration
  def up
    create_table :project_pictures, primary_key: :project_picture_id do |t|
      t.string :image_path, null: false
      t.integer :project_id, null: false
    end
    add_foreign_key :project_pictures, :projects, column: :project_id, primary_key: :project_id
  end

  def down
    drop_table :project_pictures
  end
end
