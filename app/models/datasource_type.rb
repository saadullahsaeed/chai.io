class DatasourceType < ActiveRecord::Base
  has_many :datasources
  #attr_accessible :name
end
