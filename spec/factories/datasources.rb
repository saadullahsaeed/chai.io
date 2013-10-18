FactoryGirl.define do
  factory :datasource do
    user
    datasource_type
    
    name "Local Mysql"
    config({ :host => 'localhost', :user => 'root', :password => '', :database => 'chai_sql_test'})
  end
end