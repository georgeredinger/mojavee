
desc "Deploy basic application directories" 
task :deploy => :environment do
  dirs = %w{ app lib test public config}
  onserver = "redinger@redingerdressage.com:/home/redinger/sites/rails/" 
  dirs.each do | dir|
    `rsync -avz -e ssh "#{RAILS_ROOT}/#{dir}" "#{onserver}" --exclude-from "/home/george/aptana/workspace/LearningRails9/lib/tasks/exclude.txt"`
  end
  # killall dispatch.fcgi--want to do this on remote,
  # capistrano ?
  

  `beep;sleep 1;beep;sleep 1;beep`
end

task :deploydell => :environment do
  dirs = %w{ app lib test public config}
  onserver = "george@dell:/var/www/rails" 
  dirs.each do | dir|
    `rsync -avz -e ssh "#{RAILS_ROOT}/#{dir}" "#{onserver}" --exclude-from "/home/george/aptana/workspace/LearningRails9/lib/tasks/exclude.txt"`
  end
  # killall dispatch.fcgi--want to do this on remote,
  # capistrano ?
  

  `beep;sleep 1;beep;sleep 1;beep`
end
