## This is default deploy.rb created at 06.10.2011
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
$:.unshift('/usr/local/rvm/lib')
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2-p290'        # Or whatever env you want it to run in.

set :use_sudo, false

set :application, "realityrobots_com"
set :user, "realityrobots"
# if you think, this file is secured enough, you can provide your ssh password here
# otherwise, capistrano asks you each time
#set :password, "yourpasswordhere"

# this is default scm configuration, you can change scm, user and pass to anything you want
# also you can let capistrano to ask for scm password each time application is deployed
# If you need to interactively add git server to known hosts you can uncomment next line
#default_run_options[:pty] = true
#set :repository,  'git@git.yourserver.com'
set :repository,  '.git'
set :scm, 'git'
# Here you can set a passphrase if you don't use forward agent
#set :scm_passphrase, 'git'
ssh_options[:forward_agent] = true
set :branch, 'master'
#set :deploy_via, :remote_cache
set :deploy_via,  :copy 

# do not change this, your application is here!
set :deploy_to, "/data/r/realityrobots/realityrobots_com/"

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Setups bundler config file to install only production gems and run bundle install'
  task :bundle do
    run "cd #{release_path}; bundle install --deployment --without development test --path /home/realityrobots/gems"
    #run "cd /home/realityrobots/app/current; bundle install --deployment --without development test --path /home/realityrobots/gems"
  end

  desc 'Run Migration'
  task :migrate do
    run "cd #{release_path}; RAILS_ENV=production rake db:migrate"
    #run "cd #{release_path}; RAILS_ENV=production rake db:data:load"
  end

  desc 'Precompile assets after bundle is complete'
  task :assets do
    run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=production"
  end

  desc "Make necessary symlink"
  task :symlinks do
    # make links - if you need something shared between revisions (e.g. uploaded files)
    #run "ln -nfs #{deploy_to}/shared/public/ckeditor_assets/ #{release_path}/public/"
    #run "ln -nfs #{deploy_to}/shared/config/facebooker.yml #{release_path}/config/facebooker.yml"
  end

  desc "After updating code we need to populate a new database.yml"
  task :db_config, :roles => :app do
    require "yaml"

    ### use this if you want to use some template in vcs
    # buffer = YAML::load_file('config/database.yml.example')
    ## get rid of unneeded configurations
    # buffer.delete('test')
    # buffer.delete('development')
    run "if [ -f #{release_path}/config/database.yml ]; then rm #{release_path}/config/database.yml; fi"
    buffer = {}
    # create new element for envs (you can set any database)
    # envs = ['production', 'development']
    # we will use only production
    envs = ['production']
    envs.each do |env|
      buffer[env] = {}
      buffer[env]['adapter'] = "mysql2"
      buffer[env]['database'] = "realityrobots_com"
      buffer[env]['username'] = "realityrobots"
      buffer[env]['password'] = "IL6feXF,MS"
      buffer[env]['host'] = "mysql.igloonet.cz"
    end

    # safe new database configuration
    put YAML::dump(buffer), "#{release_path}/config/database.yml", :mode => 0644
    # set right for user only
    run "chmod 600 #{release_path}/config/database.yml"
    run "chmod -R go-rwx #{release_path}/app"
    run "chmod -R go-rwx #{release_path}/vendor"
    run "chmod -R go-rwx #{release_path}/lib"

    # make links - if you need something shared between revisions (e.g. uploaded files)
    #run "ln -nfs #{deploy_to}/shared/files #{release_path}/public/files"
  end
end

after 'deploy:update_code', 'deploy:cleanup'
after 'deploy:update_code', 'deploy:symlinks'
after 'deploy:update_code', 'deploy:db_config'
after 'deploy:update_code', 'deploy:bundle'
after 'deploy:update_code', 'deploy:migrate'
#after 'deploy:update_code', 'deploy:assets'

# do not change these lines
role :app, "monique.igloonet.cz"
role :web, "monique.igloonet.cz"
role :db,  "monique.igloonet.cz", :primary => true
