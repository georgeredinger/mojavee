#does git have macros that will expand to version info
#so when I look at a checked out version I can tell what version it is ?
set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'


set :db_type, "mysql"

set :deploy_via, :copy
set :get_shallow_clone, 1 
set :copy_cache, true

set :scm, :git
set :scm_username, 'george'
set :copy_exclude, [".git", "materials"]
set :chmod755, %w(app config db lib public vendor script tmp  public/dispatch.fcgi public/dispatch.rb public/.htaccess)
set :use_sudo, false

task :update_public, :roles => [:app] do  
   
   run   "ln -s ~/MojaveePhotos #{deploy_to+'/'+current_dir + '/public/photos' }"
   run  "ln -s   ~/MojaveeMovies  #{deploy_to+'/'+current_dir + '/public/movies' }"
end  

task :link_static_data, :roles => [:web] do  
   
   run   "ln -s ~/MojaveePhotos #{deploy_to+'/'+current_dir + '/public/photos' }"
   run  "ln -s   ~/MojaveeMovies  #{deploy_to+'/'+current_dir + '/public/movies' }"
end  


desc <<DESC 
tail production log files, tail's them until you kill it 
read all about it at http://www.nateclark.com/articles/tag/capistrano
DESC
task :tail_logs, :roles => :web do
  run "tail -f /home/redinger/sites/mojavee/current/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err    
  end
end

desc 'Dumps the production database to db/production_data.sql on the remote server'
task :remote_db_dump, :roles => :db, :only => { :primary => true } do
  run "cd #{deploy_to}/#{current_dir} && " +
    "#{rake} RAILS_ENV=#{rails_env} db:database_dump --trace" 
end

desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
task :remote_db_download, :roles => :db, :only => { :primary => true } do  
  execute_on_servers(options) do |servers|
    self.sessions[servers.first].sftp.connect do |tsftp|
      tsftp.get_file "#{deploy_to}/#{current_dir}/db/production_data.sql", "db/production_data.sql" 
    end
  end
end

desc 'Cleans up data dump file'
task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do  
  delete "#{deploy_to}/#{current_dir}/db/production_data.sql" 
end 

desc 'Dumps, downloads and then cleans up the production data dump'
task :remote_db_runner do
  remote_db_dump
  remote_db_download
  remote_db_cleanup
end

after "deploy:symlink", :update_public , :link_static_data 

