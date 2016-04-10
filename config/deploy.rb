require 'bundler/capistrano'

default_run_options[:shell] = '/bin/bash --login'
set :application, 'Triangle Fraternity - RHIT'
set :repository,  "https://github.com/schepedw/rhit_triangle.git"
set :deploy_to, '/export/web/rhit_triangle'
server '173.255.225.240', :app, :web, :db, :primary => true

set :user, "deployuser"
set :rails_env, :production

set :scm, :git
set :use_sudo, false
set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache
set :rvm_type, :system
set :bundle_gemfile,  'Gemfile'
set :bundle_cmd,      'bundle'
set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags, "--deployment "


set :branch do
  default_tag = `git tag`.split("\n").last

  tag = Capistrano::CLI.ui.ask "Tag to deploy (make sure to push the tag first): [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end

BP = 'bundle exec bluepill --no-privileged'

after 'deploy:update', 'bluepill:quit', 'bluepill:start'
namespace :bluepill do
  desc "Stop processes that bluepill is monitoring and quit bluepill"
  task :quit, :roles => [:app] do
    run "cd #{latest_release} && #{BP} adventure_glass stop && sleep 2 && #{BP} adventure_glass quit && sleep 2"
  end

  desc "Load bluepill configuration and start it"
  task :start, :roles => [:app] do
    run "cd #{release_path} && #{BP} load #{latest_release}/config/unicorn.pill"
  end

  desc "Prints bluepills monitored processes statuses"
  task :status, :roles => [:app] do
    run "bundle exec bluepill status"
  end
end

before 'bluepill:start', 'secrets:generate'
namespace 'secrets' do
  task :generate do
    run "cd #{release_path} && sed -i '$ d' config/secrets.yml "
    run "cd #{release_path} && echo \"  secret_key_base: $(bundle exec rake secret)\" >> config/secrets.yml"
  end
end

namespace :bundle do
  task :install, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    run "cd #{release_path} && export BUNDLE_ENV=#{rails_env}  && bundle check 2>&1 > /dev/null; if [ $? -ne 0 ] ; then  bundle install --gemfile #{release_path}/Gemfile --path  #{shared_dir} --deployment --without development test ; fi"
    on_rollback do
      if previous_release
        run "cd #{previous_release}  && bundle check 2>&1 > /dev/null; && if [ $? -ne 0 ] ; then bundle install #{shared_dir} --without test && bundle install #{shared_dir} --binstubs; fi"
      else
        logger.important "no previous release to rollback to, rollback of bundler:install skipped"
      end
    end
  end
end

before "deploy:assets:precompile", 'random:clear_files', "db:setup", "db:migrate"
namespace :db do
  desc "setup db"
  task :setup, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=#{rails_env} bundle exec rake db:setup"
  end
  task :migrate, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
  end
end

namespace 'random' do
  task :clear_files do
    run "cd #{release_path} && rm log && mkdir log && touch log/production.log"
    run "cd #{release_path} && rm tmp/pids && mkdir tmp/pids && chmod 777 tmp/pids"
  end
end

after 'deploy:assets:precompile', 'uploads:create_symlinks'
namespace :uploads do
  task :create_symlinks do
#    run "cd #{shared_path} && mkdir -p base_model_pictures"
#    run "cd #{release_path}/public && mkdir -p images"
#    run "cd #{release_path}/public/assets && if ! [ -L ./base_model_pictures ]; then ln -s #{shared_path}/base_model_pictures base_model_pictures; fi"
#    run "cd #{release_path}/public/images && if ! [ -L ./base_model_pictures ]; then ln -s #{shared_path}/base_model_pictures base_model_pictures; fi"
  end
end
