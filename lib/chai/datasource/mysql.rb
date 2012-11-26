require 'chai/datasource/base'

module Chai
  module Datasource  
    
    class Mysql < Base
      
      attr_accessor :query_str
      
      def connect
        
        host = @datasource_info['host']
        user = @datasource_info['user']
        password = @datasource_info['password']
        database = @datasource_info['database']
        
        @connection = Sequel.mysql2(:host => host, :user => user, :password => password, :database => database)

        begin
          connected = @connection.test_connection
        rescue
        end
        
        connected
      end
      
      
      def query
        
        if !@query_str
          raise "Empty Query!"
        end
        
        @connection.fetch(@query_str)
      end
        
    end
    
  end
end