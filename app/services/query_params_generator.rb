class QueryParamsGenerator
  
  def self.call(filters, params)
    return {} unless filters
    query_params = {}
    filter_objects = []
    filters.each do |i, fi|
     ph = fi['placeholder'].to_sym
     type = fi['type']
     val = params.has_key?(ph) ? params[ph] : fi['default_value'] 
     if ph && type
       filter_obj = ChaiIo::Filter::Base.get_instance fi['type'], fi['placeholder'], val
       filter_obj.value = val
       if filter_obj.validate
         query_params[ph] = filter_obj.format val
       else
         query_params[ph] = filter_obj.get_default_value
       end
       filterX = fi
       filterX['control_type'] = filter_obj.control_type
       filter_objects << filterX
     end
    end
    query_params, filter_objects
  end
  
end