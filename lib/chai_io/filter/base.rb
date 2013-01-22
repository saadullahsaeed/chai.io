module ChaiIo
  module Filter  
    
    class Base 
      
      attr_accessor :value, :placeholder
      
      #Should return the default value for that filter type
      def get_default_value
        raise 'get_default_value must be implemented'
      end
      
      
      #Should validate @value
      def validate
        raise 'validate function for filter class must be implemented'
      end
      
      #Which filter control type to render
      def control_type 
        'text'
      end
      
      def format(value)
        value
      end
    end
    
  end
end