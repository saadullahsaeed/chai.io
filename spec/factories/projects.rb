# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyProject"
    description "Description of the project"
    user_id 1
    
    factory :project_without_name do
      name nil
    end
    
    factory :project_without_user do
      user_id nil
    end
    
    factory :project_without_description do
      description nil
    end
  end
end
