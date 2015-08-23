require 'spec_helper'

describe DummyFlow do

  subject do
    DummyFlow.new
  end

  it { expect(subject.concert!).not_to be_nil }

end
