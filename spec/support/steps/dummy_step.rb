class DummyStep < Rockflow::Step

  def it_up
    puts 'Iam dummy step 1 - and here iam adding y to payload'
    add_payload :y, 2
  end

end