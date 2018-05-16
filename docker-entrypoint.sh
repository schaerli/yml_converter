#!/bin/sh

# start app
export EXECJS_RUNTIME=Node
export RAILS_ENV=production
cd /yml_converter; bundle exec rake db:migrate;  bundle exec unicorn -c config/unicorn/production.rb
