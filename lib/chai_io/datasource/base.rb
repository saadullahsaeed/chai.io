module ChaiIo
  module Datasource  
    
    class Base
      
      attr_accessor :datasource_info
      
      def init
      end
      
      def connect
      end
      
      def test_connection(config)
      end
      
      def query
      end
        
    end
    
  end
end