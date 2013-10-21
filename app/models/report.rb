class Report < ActiveRecord::Base
  belongs_to :report
  belongs_to :datasource
  belongs_to :user
  belongs_to :project
  
  serialize :config, Hash
  serialize :filters
  serialize :sharing_config
  
  validates_presence_of :title, :datasource_id, :report_type, :user_id, :config, :project_id

  after_initialize :default_values
  before_save :default_values


  scope :search_for, ->(query) { where("title LIKE ?", "%#{query}%") }


  def self.REPORT_TYPES
    {
      :table => 'Table',
      :details => 'Details (Single Row)',
      :single_value => 'Single Value',
      :bar_chart => 'Bar Chart',
      :line_chart => 'Line Chart',
      :bar_line_chart => 'Bar Line Chart',
      :pie_chart => 'Pie Chart'
    }
  end


  def report_type_text
    Report.REPORT_TYPES[report_type.to_sym]
  end


  def default_values
    self.project_id ||= 0 
  end

  
  #Enable Sharing
  def enable_sharing(password)
    self.sharing_config = {:password => password}
    self.sharing_enabled = true
    self.save
  end
  

  #Disable sharing
  def disable_sharing
    self.sharing_enabled = false
    self.sharing_config = {}
    self.save
  end  

end
