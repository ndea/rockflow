class DummyStep4 < Rockflow::Step

  def it_up
    puts "Iam dummy step 4 - and iam aggregating the result by adding all numbers from #{payload}"
    result = payload[:a] + payload[:b] + payload[:c]
    puts "Result: #{result}"
  end

end