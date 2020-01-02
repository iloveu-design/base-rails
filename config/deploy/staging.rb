set :stage, :staging
set :branch, "master"
set :rails_env, "staging"
set :nginx_server_name, 'base-rails.slowalk.dev'
set :deploy_user, 'ufofactory'
set :deploy_to, '/home/ufofactory/apps/base-rails'

set :rbenv_ruby, '2.6.3'

role :app, %w{ufofactory@slowalk.dev}
role :web, %w{ufofactory@slowalk.dev}
role :db,  %w{ufofactory@slowalk.dev}
server 'slowalk.dev', user: 'ufofactory', roles: %w{web app}, my_property: :my_value

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
