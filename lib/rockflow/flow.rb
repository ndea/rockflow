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

    def concert!
      while !steps_finished?
        ::Parallel.each(next_free_steps, in_threads: 4) do |step|
          step.it_up
          step.finish!
        end
      end
    end

    def next_free_steps
      @steps.select do |step|
        step.after_dependencies_finished? && !step.finished?
      end
    end

    def steps_finished?
      @steps.inject(true) do |result, elem|
        result = result && elem.finished?
        result
      end
    end

  end
end