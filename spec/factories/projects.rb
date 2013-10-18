
FactoryGirl.define do
  
  factory :project do
    user
    sequence(:name) {|n| "MyProject#{n}"} 
    description "Description of the project"
    
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
