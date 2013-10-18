FactoryGirl.define do
  factory :user do
    name "Saad"
    password "saad"
    password_confirmation "saad"
    new_password ""
    sequence(:email) { |n| "saadullah.saeed#{n}#{Time.now.to_i}@example.com"}
  end
end