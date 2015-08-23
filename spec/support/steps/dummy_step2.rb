class DummyStep2 < Rockflow::Step

  def it_up
    puts 'Iam dummy step 2 - and here iam adding b to payload'
    add_payload :b, 2
  end

end