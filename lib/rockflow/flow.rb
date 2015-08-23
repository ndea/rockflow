module Rockflow
  class Flow

    attr_accessor :payload, :steps

    def initialize(payload = {})
      @payload = payload
      @steps = []
    end

    def setup
    end

    def rock(klazz, opts = {})
      @steps << klazz.new(self, opts)
    end

    def concert!
      ::Parallel.each(@steps, in_processes: 2) do |step|
        step.it_up
      end
    end

  end
end