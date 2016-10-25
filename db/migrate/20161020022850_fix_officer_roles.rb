class FixOfficerRoles < ActiveRecord::Migration
  def change
    Role.delete_all

    add_column :members, :bio, :text
    add_column :roles, :job_description, :text

    add_column :roles, :role_type, :string
    remove_column :roles, :resource_type

    rename_column :roles, :resource_id, :member_id
    change_column_null :roles, :member_id, false

    rename_column :roles, :name, :title
    change_column_null :roles, :title, false

    AppConfig.officers.alumni_officers.each do |title|
      officer = AlumniOfficer.find_by_title(title)
      member = officer.member
      member.update(bio: officer.bio)
      Role.create(member_id: member.id,
                  job_description: officer.job_description,
                  title: title,
                  role_type: 'alumni'
                 )
    end

    ActiveOfficer.find_by_title('Advisor').update(title: 'Chapter Advisor')
    AppConfig.officers.active_officers.each do |title|
      officer = ActiveOfficer.find_by_title(title)
      member = officer.member
      Role.create(member_id: member.id,
                  title: title,
                  role_type: 'active'
                 )
    end

    drop_table :members_roles
  end
end
