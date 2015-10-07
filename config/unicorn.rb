rails_env = ENV['RAILS_ENV'] || 'development'

if rails_env == 'production'
  APP_PATH = '/home/homesite/homesite'
  worker_processes 2
  timeout 30
# else
#   APP_PATH = '/home/crafter/ossai'
#   worker_processes 5
#   timeout 60
end

working_directory APP_PATH + '/current'

preload_app true

listen APP_PATH + '/shared/tmp/sockets/unicorn.sock', backlog: 64
pid APP_PATH + '/shared/tmp/pids/unicorn.pid'
stderr_path APP_PATH + '/shared/log/unicorn.stderr.log'
stdout_path APP_PATH + '/shared/log/unicorn.stdout.log'

before_exec do |server|
 ENV['BUNDLE_GEMFILE'] = APP_PATH + '/current/Gemfile'
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill(:QUIT, File.read(old_pid).to_i)
    rescue
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
