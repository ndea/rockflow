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

    # Returns true or false depending if the flow raised any errors or violated any conditions.
    # @return [TrueClass, FalseClass] returns true if no exception is raised else false.
    def concert
      execute_steps.inject(true) do |result, elem|
        result && !elem.errors.any?
      end
    end

    # Returns all steps if successfull. If any error is raised inside the step it is raised.
    # @return [Array] array of all defined steps in the flow.
    def concert!
      execute_steps
      @steps.map do |step|
        step.errors
      end.flatten.each do |error|
        raise error
      end
    end

    def next_free_steps
      @steps.select do |step|
        step.after_dependencies_finished? && !step.finished? && !step.failed?
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
        break if next_free_steps.blank?
        ::Parallel.each(next_free_steps, threads_or_processes.to_sym => Rockflow.configuration.thread_or_processes) do |step|
          begin
            step.execute_pre_conditions
            step.it_up unless step.failed?
            step.execute_post_conditions
            step.finish! unless step.failed?
          rescue => e
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