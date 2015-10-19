Rockflow.configure do |config|
  # Define if you want to use processes instead of threads.
  # Please keep in mind to set the option use_threads to false if you want to use processes
  # Processes are set to false by default
  # config.use_processes = false

  # Define if you want to use threads instead of processes.
  # Please keep in mind to set the option use_processes to false if you want to use threads.
  # Threads are set to true by default
  # config.use_threads = true

  # Set the count of threads or processes to be used by rockflow.
  # The default value is 4
  # config.thread_or_processes = 4
end