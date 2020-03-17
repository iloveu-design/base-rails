# config valid only for current version of Capistrano
lock "3.11.2"

set :application, 'base-rails'
set :repo_url, 'git@github.com:slowalk/base-rails.git'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :ssh_options, {forward_agent: true}

# set :bundle_binstubs, nil
set :linked_files, %w{.env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle storage public/system public/files}

set :keep_releases, 5

namespace :unicorn do
  Rake::Task["restart"].clear_actions
  desc "restart unicorn"
  task :restart do
    on roles :app do
      sudo "/etc/init.d/#{fetch(:unicorn_service)}", 'restart'
    end
  end
end