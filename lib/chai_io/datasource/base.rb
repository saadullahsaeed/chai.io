module ChaiIo
  module Datasource  
    
    class Base
      
      attr_accessor :datasource_info, :query_params
      
      def init
      end
      
      def connect
      end
      
      def test_connection(config)
      end
      
      def query
      end
        
      def cache_data(timeout)
      end    
      
    end
    
  end
end