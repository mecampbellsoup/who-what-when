# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :receiver do
    phone "+17403190208"
  end

  factory :bad_number_receiver, :parent => :receiver do
    phone "319-0208"
  end

  factory :no_number_receiver, :parent => :receiver do
    phone nil
  end
end
