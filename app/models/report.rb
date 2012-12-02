class Report < ActiveRecord::Base
  belongs_to :report
  belongs_to :datasource
  
  attr_accessible :config, :filters, :description, :datasource_id, :title, :report_type, :user_id
  
  serialize :config, Hash
  serialize :filters
  
  validates_presence_of :title, :datasource_id, :report_type, :user_id, :config
end
