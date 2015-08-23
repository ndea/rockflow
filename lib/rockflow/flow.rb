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
      @steps << klazz.new(self)
    end

    def concert!
      ::Parallel.each(@steps, in_processes: 2) do |step|
        step.it_up
      end
    end

  end
end