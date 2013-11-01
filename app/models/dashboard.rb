class Dashboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :dashboard_reports
  
  validates_presence_of :title, :project, :user
  validates_uniqueness_of :title, :scope => [:project_id]

end
