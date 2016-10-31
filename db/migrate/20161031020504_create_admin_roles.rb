class CreateAdminRoles < ActiveRecord::Migration
  def change
    Role.find_by_title('Nerd').update_attributes(role_type: 'admin', title: 'Alumni Admin')
  end
end
