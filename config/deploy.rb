set :application, "fake_authorize_net"
set :repository,  "git://github.com/sumskyi/fake_authorizenet_arb.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "10.1.0.189"                          # Your HTTP server, Apache/etc
role :app, "10.1.0.189"                          # This may be the same as your `Web` server
role :db,  "10.1.0.189", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/deploy/public_html/#{application}"
set :rails_env, "staging"

set :use_sudo, false

set :user, "vsumskyi"
ssh_options[:username] = user
ssh_options[:keys] = [ENV['HOME'] + "/.ssh/id_rsa", ENV['HOME'] + "/.ssh/id_dsa"]

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :create_symlinks do
    #run "ln -nfs #{deploy_to}/#{shared_dir}/database.yml #{release_path}/config/database.yml"
  end
  task :bundle do
    run "cd #{release_path} && bundle install --path=#{deploy_to}/#{shared_dir}/vendor"
  end
end

after 'deploy:update_code', 'deploy:create_symlinks'
after 'deploy:update_code', 'deploy:bundle'
