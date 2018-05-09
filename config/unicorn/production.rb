#listen "172.18.0.112:2529"  # listen to port 3000 on the loopback interface
listen "127.0.0.1:3002"  # listen to port 3000 on the loopback interface

working_directory "/yml_converter"

worker_processes 4 # this should be >= nr_cpus

#pid "/home/schaerli/production/yml2xls/current/tmp/pids/unicorn.pid"
#stderr_path "/home/schaerli/production/yml2xls/current/log/unicorn.log"
#stdout_path "/home/schaerli/production/yml2xls/current/log/unicorn.log"
