FactoryGirl.define do
  factory :report do
    
    user
    datasource
    project
    
    datasource_id 1
    title "MyReport"
    description "This is a test report for Factory"
    report_type "table"
    config({'query' => 'select id, title from reports'})
    filters []
    
    factory :report_with_filters do
      filters [{'type' => 'date', 'placeholder' => 'start'}, {'type' => 'date', 'placeholder' => 'end'}]
    end
    
  end
end