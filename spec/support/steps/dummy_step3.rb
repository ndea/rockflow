class DummyStep3 < Rockflow::Step

  def it_up
    puts "Iam dummy step 3 - and this is the payload so far #{payload}"
  end

end