FactoryGirl.define do
  factory :report do
    
    association :datasource
    association :user
    
    title "MyReport"
    description "This is a test report for Factory"
    report_type "table"
    config({:query => 'select * from reports'})
    
    factory :report_with_filters do
      filters({:type => 'date', :placeholder => 'start'})
    end
    
  end
end