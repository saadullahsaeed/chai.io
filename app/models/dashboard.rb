class Dashboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :dashboard_reports, dependent: :destroy

  accepts_nested_attributes_for :dashboard_reports, allow_destroy: true

  validates_presence_of :title, :project, :user
  validates_uniqueness_of :title, :scope => [:project_id]
end
