module Rockflow
  class Step
    attr_accessor :flow, :status

    def initialize(flow, opts = {})
      @flow = flow
      @after_dependencies = []
      @status = :not_started
      add_after_dependencies(*opts[:after])
    end

    def it_up
    end

    def payload
      @flow.payload
    end

    def finish!
      @status = :finished
    end

    def add_payload(key, value)
      @flow.payload[key] = value
    end

    def add_after_dependencies(deps = [])
      [deps].flatten.each do |dep|
        @after_dependencies << dep
      end
    end

  end
end