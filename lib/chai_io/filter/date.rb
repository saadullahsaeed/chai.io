module ChaiIo
  module Filter  
    
    class Date < Base 
      
      #Should return the default value for that filter type
      def get_default_value
        Object::Date.today.to_s
      end
      
      
      #Should validate @value
      def validate
        @value != nil && @value != ''
      end
      
      
      #Which filter control type to render
      def control_type 
        'datepicker'
      end
      
    end
    
  end
end