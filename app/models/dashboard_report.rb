class DashboardReport < ActiveRecord::Base
  belongs_to :dashboard
  belongs_to :report
  
  validates_presence_of :report_id, :report_index
end
