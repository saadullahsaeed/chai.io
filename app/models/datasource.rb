class Datasource < ActiveRecord::Base
  belongs_to :user
  belongs_to :datasource_type
  
  attr_accessible :name, :config, :datasource_type_id, :user_id
  
  validates_presence_of :user_id, :name, :datasource_type_id, :config

  serialize :config, Hash
  attr_encrypted :config, :key => ChaiIo::Application.config.secret_token, :marshal => true
end
