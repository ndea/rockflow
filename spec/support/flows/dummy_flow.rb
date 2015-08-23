require_relative '../steps/dummy_step'
require_relative '../steps/dummy_step2'
require_relative '../steps/dummy_step3'

class DummyFlow < Rockflow::Flow

  def setup
    rock DummyStep
    rock DummyStep2
    rock DummyStep3
  end

end