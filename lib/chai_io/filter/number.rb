module ChaiIo
  module Filter  
    
    class Number < Base 
      
      #Should return the default value for that filter type
      def get_default_value
        0
      end
      
      
      #Should validate @value
      def validate
        @value != nil && @value != ''
      end
      
    end
    
  end
end