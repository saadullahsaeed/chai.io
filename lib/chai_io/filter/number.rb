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
      
      #
      def format(value)
        value.to_i
      end
    end
    
  end
end