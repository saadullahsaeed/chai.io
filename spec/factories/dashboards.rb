# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard do
    user_id 1
    project_id 1
    title "MyString"
    template_id 1
  end
end
