class ReportRunner

  attr_accessor :query_params, :columns, :data


  def initialize(report, params)
    @report = report
    @params = params
  end


  def run
    @query_params = prepare_query_params @report.filters, @params
    dsource = get_datasource_object @report
    dsource.query_params = @query_params
    dsource.run_report
    @columns = dsource.columns
    @data = dsource.data
    @data
  end


  #
  def get_datasource_object(report)
    ChaiIo::Datasource::Base.get_instance report
  end


  #Inject Filters into Query
  def prepare_query_params(filters, params)
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
    ChaiIo::Filter::Base.get_instance type, placeholder, value
  end

end
