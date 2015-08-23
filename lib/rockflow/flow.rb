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
      results = ::Parallel.each(@steps, in_threads: 4) do |step|
        step.it_up
        step.finish!
        step
      end
      results
    end

  end
end