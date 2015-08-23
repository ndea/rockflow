class DummyStep < Rockflow::Step

  def it_up
    puts 'Iam dummy step 1 - and here iam adding a to payload'
    add_payload :a, 2
  end

end