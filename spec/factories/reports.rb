FactoryGirl.define do
  factory :report do
    
    association :datasource
    association :user
    association :project
    
    title "MyReport"
    description "This is a test report for Factory"
    report_type "table"
    config({'query' => 'select id, title from reports'})
    datasource_id 1
    
    factory :report_with_filters do
      filters([{:type => 'date', :placeholder => 'start'}, {:type => 'date', :placeholder => 'end'}])
    end
    
  end
end