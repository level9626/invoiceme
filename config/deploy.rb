set :application, 'invoiceme'
set :deploy_user, 'deployer'

# setup repo details
set :scm, :git
set :repo_url, 'git@github.com:4ndrik/invoiceme.git'

# setup rbenv.
set :rbenv_type, :system
set :rbenv_ruby, '2.2.1'
set :rbenv_path, "/home/#{fetch(:deploy_user)}/.rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# how many old releases do we want to keep, not much
set :keep_releases, 5

# files we want symlinking to specific entries in shared
set :linked_files, %w{config/database.yml}
set(:linked_dirs,  %w{
  bin
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
})

set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
))

set(:ssh_options, {
  port: 13666,
  forward_agent: true,
  user: fetch(:user),
  keys: %w(~/.ssh/id_rsa.pub)
})

set(:symlinks, [
   {
       source: "nginx.conf",
       link: "/etc/nginx/sites-enabled/{{full_app_name}}"
   },
   {
       source: "log_rotation",
       link: "/etc/logrotate.d/{{full_app_name}}"
   }
])

# puma settings
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{fetch(:shared_path)}/tmp/sockets/#{fetch(:full_app_name)}_puma.sock"
set :puma_state,      "#{fetch(:shared_path)}/tmp/pids/puma.state"
set :puma_pid,        "#{fetch(:shared_path)}/tmp/pids/puma.pid"
set :puma_access_log, "#{fetch(:release_path)}/log/puma.error.log"
set :puma_error_log,  "#{fetch(:release_path)}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :sudo_prompt,     "deplyshveplypokypak%%66123892323asdzxllasd"

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  # before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  # after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after 'deploy:publishing', 'deploy:restart'
end