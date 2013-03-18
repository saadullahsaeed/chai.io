FactoryGirl.define do
  factory :datasource do
    association :datasource_type
    association :user
    
    name "Local Mysql"
    config({ :host => 'localhost', :user => 'root', :password => '', :database => 'chai_sql_test'})
    datasource_type_id 1
  end
end