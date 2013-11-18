# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    to "MyString"
    from "MyString"
    body "MyString"
    send_at "2013-11-18 15:48:03"
    references ""
  end
end
