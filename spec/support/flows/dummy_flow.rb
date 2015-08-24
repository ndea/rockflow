require_relative '../steps/dummy_step'
require_relative '../steps/dummy_step2'
require_relative '../steps/dummy_step3'
require_relative '../steps/dummy_step4'

class DummyFlow < Rockflow::Flow

  def setup
    rock DummyStep
    rock DummyStep2, params: {url: 'http://api.de'}
    rock DummyStep3
    rock DummyStep4, after: [DummyStep, DummyStep2, DummyStep3]
  end

end