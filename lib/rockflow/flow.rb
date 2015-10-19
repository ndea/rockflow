module Rockflow
  class Flow

    attr_accessor :steps, :payload

    def initialize(payload = {})
      @steps = []
      @payload = payload
      setup
    end

    def setup
    end

    def rock(klazz, opts = {})
      @steps << klazz.new(self, opts)
    end

    def concert
      execute_steps.inject(true) do |result, elem|
        result && !elem.errors.any?
      end
    end

    def concert!
      execute_steps
    end

    def next_free_steps
      @steps.select do |step|
        step.after_dependencies_finished? && !step.finished?
      end
    end

    def steps_finished?
      @steps.inject(true) do |result, elem|
        result = result && (elem.finished? || elem.failed?)
        result
      end
    end

    def execute_steps
      while !steps_finished?
        ::Parallel.each(next_free_steps, threads_or_processes.to_sym => Rockflow.configuration.thread_or_processes) do |step|
          begin
            step.execute_pre_conditions
            step.it_up unless step.failed?
            step.execute_post_conditions
            step.finish! unless step.failed?
          rescue Exception => e
            step.fail!
            step.errors << e
            raise Parallel::Break, e.message
          end
        end
      end
      @steps
    end

    private

    def threads_or_processes
      if Rockflow.configuration.use_threads
        :in_threads
      else
        :in_processes
      end
    end

  end
end