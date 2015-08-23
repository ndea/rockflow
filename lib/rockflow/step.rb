module Rockflow
  class Step
    attr_accessor :flow

    def initialize(flow)
      @flow = flow
    end

    def it_up
    end

    def payload
      @flow.payload
    end

    def add_payload(key, value)
      @flow.payload[key] = value
    end

  end
end