# STAGING-specific deployment configuration
# please put general deployment config in config/deploy.rb
#role :dell, "dell"

set :rails_env, "production"
set :application, "dell"

set :deploy_to, "/var/www/mojavee"
set :application, "rails"
set :repository, ".git"
set :user, "george"
set :domain, "dell"

role :app, "#{domain}"
role :web, "#{domain}"
role :db,  "#{domain}", :primary => true

task :restart_web_server, :roles => :web do
 # run "killall dispatch.fcgi"
 puts "restart_web_server"
end
task :update_public, :roles => [:app] do  
  #no need to change 
   #run "chmod 755 /home/redinger/public_html/mojavee"  
   #run "chmod 755 /home/redinger/public_html/mojavee/dispatch.*" 
 end  
 


desc "Restart Passenger" 
deploy.task :restart, :roles => :app do
  task :restart, :roles => :app do
    run "touch /var/www/mojavee/tmp/restart.txt" 
  end
   #run "killall dispatch.fcgi"
#   puts "restart"
end

task :restart_web_server, :roles => :web do
  puts "pretending to be restarting web server"
end

after "deploy:start", :restart_web_server
