require 'rockflow/version'
require 'rockflow/flow'
require 'rockflow/step'
require 'rockflow/errors/post_condition'
require 'rockflow/errors/pre_condition'
require 'parallel'
module Rockflow
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :use_processes
    attr_accessor :use_threads
    attr_accessor :thread_or_processes

    def initialize
      @use_processes = false
      @use_threads = true
      @thread_or_processes = 4
    end
  end
end
