require 'chai_io/datasource/base'

module ChaiIo
  module Datasource  
    
    class Mysql < Base
      
      attr_accessor :query_str
      
      def connect
        @connection = Sequel.mysql2 @report.datasource.config
        begin
          connected = @connection.test_connection
        rescue
        end
        connected
      end
      
      #Query
      def query
        @query_str = @report.config['query']
        unless @query_str
          raise "Empty Query!"
        end
        @connection.fetch(@query_str, @query_params)
      end
        
    end #MySql
    
  end
end