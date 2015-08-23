class DummyStep2 < Rockflow::Step

  def it_up
    puts 'Iam dummy step 2 - and here iam adding z to payload'
    add_payload :z, 2
  end

end