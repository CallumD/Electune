require 'bundler/capistrano'
require 'cape'

DATABASE_CONFIG = '/home/callum/database.yml'

default_run_options[:pty] = true

set :application, "Electune"
set :repository,  "git@github.com:CallumD/Electune.git"
set :user, "callum"
set :port, 2221
set :scm, :git
set :deploy_to, "/home/callum/Electune"

role :web, "callum.mine.nu"
role :app, "callum.mine.nu"
role :db,  "callum.mine.nu", :primary => true

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

namespace :deploy do

  Cape do
    # Create Capistrano recipes for all Rake tasks.
    mirror_rake_tasks
  end

  before 'deploy:update_code', 'deploy:check_config'
  after 'deploy:update_code', 'deploy:assets:precompile'
  before 'deploy:assets:precompile', 'deploy:create_config'
  after 'deploy:create_config', 'deploy:migrate'

  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    start
  end

  desc "Create database config"
  task :create_config do
    run "cp #{DATABASE_CONFIG} #{release_path}/config/database.yml"
  end

  desc "Check database config exists"
  task :check_config do
    unless remote_file_exists?(DATABASE_CONFIG)
      raise CommandError.new("Cannot find database configuration file")
    end
  end
end
