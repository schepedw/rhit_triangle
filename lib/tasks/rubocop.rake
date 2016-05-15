task :rubocop do
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

task default: :rubocop
