require 'chai/datasource/base'

module ChaiIo
  module Datasource  
    
    class Mysql < Base
      
      attr_accessor :query_str
      
      def connect
        
        @connection = Sequel.mysql2 @datasource_info

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