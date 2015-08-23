require 'spec_helper'

describe DummyFlow do

  subject do
    DummyFlow.new({x: 1})
  end

  it { expect(subject.concert!).not_to be_nil }
end
