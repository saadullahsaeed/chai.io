module ChaiIo
  module Cache  
    
    class Base
      
      def init
      end
      
      #Get from cache
      def get(key)
        raise "'get' not implemented"
      end  
      
      #Set in cache
      def set(key, value, expiry)
        raise "'set' not implemented"
      end
      
      def serialize(value)
        value.to_json
      end
      
      def unserialize(value)
        JSON.parse(value)
      end
      
    end
    
  end
end