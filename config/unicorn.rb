listen "127.0.0.1:3000"

pid "tmp/pids/unicorn.pid"

worker_processes 2

timeout 15

preload_app true

ROOT = File.dirname(File.dirname(__FILE__))
stdout_path "#{ROOT}/log/unicorn-stdout.log"
stderr_path "#{ROOT}/log/unicorn-stderr.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

start_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
