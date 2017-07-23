listen "127.0.0.1:3000"  # listen to port 3000 on the loopback interface

# working_directory "/Users/schaerli/rails/yml_converter"

worker_processes 4 # this should be >= nr_cpus

pid "/Users/schaerli/rails/yml_converter/tmp/pids/unicorn.pid"
stderr_path "/Users/schaerli/rails/yml_converter/log/unicorn.log"
stdout_path "/Users/schaerli/rails/yml_converter/log/unicorn.log"
