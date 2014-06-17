class Report < ActiveRecord::Base
  belongs_to :report
  belongs_to :datasource
  belongs_to :user
  belongs_to :project
  
  serialize :config, Hash
  serialize :filters
  serialize :sharing_config

  acts_as_taggable
  
  validates_presence_of :title, :datasource_id, :report_type, :user_id, :config, :project_id


  scope :search_for, ->(query) { where("title LIKE ?", "%#{query}%") }
  scope :all_starred, -> { where("starred = ?", true) }
  scope :all_shared, -> { where("sharing_enabled = ?", true) }


  def self.REPORT_TYPES
    {
      :table => 'Table',
      :details => 'Details (Single Row)',
      :single_value => 'Single Value',
      :bar_chart => 'Bar Chart',
      :line_chart => 'Line Chart',
      :bar_line_chart => 'Bar Line Chart',
      :pie_chart => 'Pie Chart',
      :scatter_chart => 'Scatter Chart'
    }
  end


  def self.search query
    self.search_for(query) + self.tagged_with(query)
  end


  def report_type_text
    Report.REPORT_TYPES[report_type.to_sym]
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


  def star
    self.starred = true
    self.save
  end


  def unstar
    self.starred = false
    self.save
  end

end
