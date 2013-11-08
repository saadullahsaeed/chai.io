require 'chai_io/datasource/mysql'

module ChaiIo
  module Datasource  
    
    class Sqlite < Mysql
      
      def get_connection(config)
        config['database'] = config['host']
        Sequel.sqlite config
      end
       
    end #Sqlite

  end
end