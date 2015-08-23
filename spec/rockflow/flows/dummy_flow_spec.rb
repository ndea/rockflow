require 'spec_helper'

describe DummyFlow do

  subject do
    DummyFlow.new({x: 1})
  end

  it { expect(subject.concert!).to be_nil }
end
