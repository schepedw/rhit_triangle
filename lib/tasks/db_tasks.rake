namespace :db do
  task :create_roles do
    db_config = YAML.load_file('config/database.yml')
    role = db_config[Rails.env]['username']
    sh "createuser --createdb --login #{role}|| echo role #{role} already exists."
  end
end
task 'db:create' => 'db:create_roles'
