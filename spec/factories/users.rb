FactoryGirl.define do
  factory :user do
    name "Saad"
    password "saad"
    new_password ""
    sequence(:email) { |n| "saadullah.saeed#{n}@example.com"}
  end
end