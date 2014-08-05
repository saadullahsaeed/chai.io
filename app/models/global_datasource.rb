class GlobalDatasource < ActiveRecord::Base
  belongs_to :datasource_type
  
  validates_presence_of :name, :datasource_type_id, :config

  serialize :config, Hash
  attr_encrypted :config, :key => ChaiIo::Application.config.secret_token, :marshal => true
end
