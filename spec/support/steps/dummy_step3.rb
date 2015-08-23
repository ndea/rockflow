class DummyStep3 < Rockflow::Step

  def it_up
    puts 'Iam dummy step 2 - and here iam adding c to payload'
    add_payload :c, 2
  end

end