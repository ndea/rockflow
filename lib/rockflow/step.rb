module Rockflow
  class Step
    attr_accessor :flow, :status

    def initialize(flow, opts = {})
      @flow = flow
      @after_dependencies = []
      @status = :not_started
      add_after_dependencies(opts[:after])
    end

    def it_up
    end

    def payload
      @flow.payload
    end

    def finish!
      @status = :finished
    end

    def finished?
      @status == :finished
    end

    def add_payload(key, value)
      @flow.payload[key] = value
    end

    def add_after_dependencies(deps = [])
      [deps].flatten.each do |dep|
        @after_dependencies << dep
      end
    end

    def after_dependencies_finished?
      @after_dependencies.inject(true) do |result, elem|
        dependent_steps_running = !(@flow.steps.select do |step|
          step.class == elem && !step.finished?
        end.any?)
        result = result && dependent_steps_running
        result
      end
    end

  end
end