module ChaiIo
  module Filter  
    
    class Date < Base 
      
      #Should return the default value for that filter type
      def get_default_value
        #Date.today.to_s
        '2012-12-28'
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