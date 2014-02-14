module ChaiIo
  module Report

    private

      # Load report data - need to re-factor this
      def load_report_data(report)
        @query_params = get_query_params report.filters, params
        dsource = get_datasource_object report
        dsource.query_params = @query_params
        
        begin
         dsource.run_report
         @columns = dsource.columns.to_json
         puts @columns
         @data = dsource.data.to_json
        rescue Sequel::DatabaseError => e
         @query_error = true
         flash.now[:error] = "Query Error: #{e.message}"
        rescue Timeout::Error => e
         @query_error = true
         flash.now[:error] = "Query timed out."
        rescue => e
         flash.now[:error] = "Error: #{e.message}"
         @connection_error = true
        end

        @data
      end


      def get_datasource_object(report)
       type = report.datasource.datasource_type.name
       dsource = eval("ChaiIo::Datasource::#{type.capitalize}").new
       dsource.report = report
       dsource
      end


      #Inject Filters into Query
      def get_query_params(filters, params)
       return {} unless filters
       query_params = {}
       @filters = []
       filters.each do |i, fi|
         ph = fi['placeholder'].to_sym
         type = fi['type']
         val = params.has_key?(ph) ? params[ph] : fi['default_value'] 
         if ph && type
           filter_obj = get_filter_object fi['type'], fi['placeholder'], val
           filter_obj.value = val
           if filter_obj.validate
             query_params[ph] = filter_obj.format val
           else
             query_params[ph] = filter_obj.get_default_value
           end
           
           filterX = fi
           filterX['control_type'] = filter_obj.control_type
           @filters << filterX
         end
       end
       query_params
      end


      #Create an object for the filter
      def get_filter_object(type, placeholder, value)
        fo = eval("ChaiIo::Filter::#{type.capitalize}").new
        fo.value = value
        fo
      end

  end
end