module Rockflow
  class Flow

    attr_accessor :steps

    def initialize
      @steps = []
      setup
    end

    def setup
    end

    def rock(klazz)
      @steps << klazz.new(self)
    end

    def concert!
      ::Parallel.each(@steps, in_processes: 2) do |step|
        step.it_up
      end
    end

  end
end