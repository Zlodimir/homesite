lock '3.4.0'

current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch,      ENV['branch'] || current_branch || 'master'

set :application, 'homesite'
set :repo_url,    'git@github.com:Zlodimir/homesite.git'

set :rvm_type,         :auto
set :rvm_ruby_version, 'ruby-2.2.2@homesite'

set :format,    :pretty
set :log_level, :debug

set :linked_files, %w{config/database.yml config/secrets.yml }
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :keep_releases, 5

set :pty, false
