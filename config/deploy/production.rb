role :web, "localhost"  # CHANGE THESE LINES TO USE YOUR OCS SERVER NAME
role :app, "localhost"
role :db,  "localhost", :primary => true


set :deploy_to, "/home/schaerli/production/#{fetch(:application)}"  # CHANGE THIS LINE TO POINT TO THE CORRECT PATH
set :use_sudo, false

set :ssh_options, {
  user: "schaerli",
  forward_agent: true,
  port: 1025
}
set :normalize_asset_timestamps, false
set :rails_env, :production

set :default_env, {
  'http_proxy' => 'http://192.168.0.1:3128',
  'ftp_proxy' => 'http://192.168.0.1:3128',
  'https_proxy' => 'http://192.168.0.1:3128',
}

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end
