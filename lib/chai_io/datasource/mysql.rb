require 'chai_io/datasource/base'

module ChaiIo
  module Datasource  
    
    class Mysql < Base
      
      attr_accessor :query_str

      def get_connection(config)
        Sequel.mysql2 config
      end
      

      def test_connection(config)
        begin
          get_connection(config).test_connection
        rescue
          return false
        end
        return true
      end
      

      def connect
        @connection = get_connection @report.datasource.config
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