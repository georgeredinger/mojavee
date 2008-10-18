namespace :db do
  desc <<DESC 
  "Dump the current database to a MySQL file" 
  "found this on the internet, need to debug..."
  "what I want to do is, dump the database on the deployment machine"
  "and get it into the development machine"
DESC
  task :database_dump do
    load 'config/environment.rb'
    abcs = ActiveRecord::Base.configurations
    case abcs[RAILS_ENV]["adapter"]
    when 'mysql'
      ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
      File.open("db/#{RAILS_ENV}_data.sql", "w+") do |f|
        if abcs[RAILS_ENV]["password"].blank?
          f << `mysqldump -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} #{abcs[RAILS_ENV]["database"]}`
        else
          f << `mysqldump -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} -p#{abcs[RAILS_ENV]["password"]} #{abcs[RAILS_ENV]["database"]}`
        end
      end
    else
      raise "Task not supported by '#{abcs[RAILS_ENV]['adapter']}'" 
    end
  end

  desc "Refreshes your local development environment to the current production database" 
  task :production_data_refresh do
    `rake remote:exec ACTION=remote_db_runner --trace`
    `rake db:production_data_load --trace`
  end 

  desc "Loads the production data downloaded into db/production_data.sql into your local development database" 
  task :production_data_load do
    load 'config/environment.rb'
    abcs = ActiveRecord::Base.configurations
    case abcs[RAILS_ENV]["adapter"]
    when 'mysql'
      ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
      if abcs[RAILS_ENV]["password"].blank?
        `mysql -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} #{abcs[RAILS_ENV]["database"]} < db/production_data.sql`
      else
        `mysql -h #{abcs[RAILS_ENV]["host"]} -u #{abcs[RAILS_ENV]["username"]} -p#{abcs[RAILS_ENV]["password"]} #{abcs[RAILS_ENV]["database"]} < db/production_data.sql`
      end
    else
      raise "Task not supported by '#{abcs[RAILS_ENV]['adapter']}'" 
    end
  end

end

#  role :db,  "caboo.se", :primary => true
# 2 set :user, "bananas"
# 3 
# 4 desc "Backup the database"
# 5 task :backup, :roles => :db, :only => { :primary => true } do
# 6   filename = "/tmp/#{application}.dump.#{Time.now.to_f}.sql.bz2"
# 7 
# 8   on_rollback { delete filename }
# 9   run "mysqldump -u root -p mephisto_production | bzip2 -c > #{filename}" do |ch, stream, out|
#10     ch.send_data "assword\n" if out =~ /^Enter password:/
#11     # set this to your db password.. yuk!
#12   end
#13   `rsync #{user}@#{roles[:db][0].host}:#{filename} #{File.dirname(__FILE__)}/../backups/`
#14   delete filename
#15 end
