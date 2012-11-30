class ReportSnapshots < ActiveRecord::Base
  attr_accessible :report_data, :report_id, :saved_on, :user_id
end
