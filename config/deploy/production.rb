# PRODUCTION-specific deployment configuration
# please put general deployment config in config/deploy.rb

#role :redingerdressage, "redingerdressage.com"
set :rails_env, "production"
set :deploy_to, "/home/redinger/sites/mojavee"
set :application, "rails"
set :repository, ".git"
set :user, "redinger"
set :domain , "mojavee.com"
role :app, "#{domain}"
role :web, "#{domain}"
role :db,  "#{domain}", :primary => true

task :restart_web_server, :roles => :web do
  run "killall dispatch.fcgi"
 puts "restart_web_server"
end
task :update_public, :roles => [:app] do  
   run "chmod 755 /home/redinger/sites/mojavee/current/public"  
   run "chmod 755 /home/redinger/sites/mojavee/current/public/dispatch.*" 
 end  
 
desc "pretend to restart bluehost" 
deploy.task :restart, :roles => :app do
  task :restart, :roles => :app do
     run "killall dispatch.fcgi"
  end
   
end

task :restart_web_server, :roles => :web do
  puts "pretending to be restarting web server"
end

after "deploy:start", :restart_web_server
