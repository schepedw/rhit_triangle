class CreateProjectStatuses < ActiveRecord::Migration
  def up
    create_table :project_statuses, primary_key: :project_status_id do |t|
      t.string :status, default: 'backlog'
    end
  end

  def down
    drop_table :project_statuses
  end
end
