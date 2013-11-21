# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body "Remind me that Factory Girl is awesome in 5 seconds"
    send_at Chronic.parse("in 5 seconds")
    association :receiver
    
    factory :invalid_message do
      body nil
    end
    
  end

  # factory :invalid_message, :parent => :message do
  #   body nil
  # end
end
