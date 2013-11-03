class DashboardReport < ActiveRecord::Base
  belongs_to :dashboard

  validates_presence_of :report_id, :report_index
end
