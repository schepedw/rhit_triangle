class AddSortValToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :sort_val, :integer, unique: true
    execute("CREATE SEQUENCE projects_sort_val_seq INCREMENT BY 1 START WITH #{Project.count}")
    execute("ALTER TABLE projects ALTER COLUMN sort_val SET DEFAULT nextval('projects_sort_val_seq'::regclass)")
    Project.all.each_with_index do |project, idx|
      Project.connection.execute(
        "UPDATE projects SET sort_val = #{idx}
        WHERE project_id = #{project.id}"
      )
    end
    completed_status = ProjectStatus.find_or_create_by(status: 'Complete')
    execute("UPDATE projects SET sort_val = 10000 where project_status_id = #{completed_status.id} or price = 0")
    change_column_null :projects, :sort_val, :false
  end

  def down
    remove_column :projects, :sort_val
  end
end
