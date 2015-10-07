set :stage,        :production
set :rails_env,    :production
set :deploy_to,    '/home/homesite/homesite'
set :unicorn_init, '/etc/init.d/net_zlodimir_unicorn'

server 'zlodimir.minidns.net', user: 'homesite', port: 2244, roles: %w{app web db}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, fetch(:unicorn_init), :restart
    end
  end

  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, fetch(:unicorn_init), :start
    end
  end

  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, fetch(:unicorn_init), :stop
    end
  end

  after :publishing, :restart
  after :finishing, :cleanup
end
