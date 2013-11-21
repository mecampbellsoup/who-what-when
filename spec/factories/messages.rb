# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do |f|
    f.receiver Receiver.new(:phone => "+17403190208")
    f.body "Remind me that Factory Girl is awesome in 5 seconds"
    f.send_at "2013-11-21 15:48:03"
  end
end
