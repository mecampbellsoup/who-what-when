# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :receiver do
    phone "+17403190208"
  end

  factory :bad_receiver, :class => :receiver do
    phone "319-0208"
  end
end
