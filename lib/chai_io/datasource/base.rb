require 'timeout'

module ChaiIo
  module Datasource  
    
    class Base
      
      class << self
        def get_instance(report)
          type = report.datasource.datasource_type.name
          dsource = eval("ChaiIo::Datasource::#{type.capitalize}").new
          dsource.report = report
          dsource
        end
      end
      
      attr_accessor :report, :datasource_info, :query_params, :data, :columns 
      
      def init
        @cache_obj = nil
      end
      
      def connect
        raise "Connect not implemented"
      end
      
      def test_connection(config)
      end
      
      def query
        raise "Method 'query' not implemeneted"
      end
      
      #Run Report
      def run_report
        connected = connect
        raise "Cannot connect to the data source!" unless connected
        
        result = nil
        Timeout::timeout(get_query_timeout) { result = fetch }
        
        @columns = result['columns']
        @data = get_formatted_data result['data']
      end
      
      
      #Get Formatted Data
      def get_formatted_data(result)
         formatter = ChaiIo::Formatter::Base.new
         formatter.data = result
         formatter.format
      end
      
      
      def get_query_timeout
        ChaiIo::Application.config.query[:timeout]
      end
      
      def is_caching_enabled
        ChaiIo::Application.config.redis_caching[:enabled] && @report.cache_time > 0
      end
      
      def make_result_object(columns, data)
        {:columns => columns, :data => data}.as_json
      end
      
      #Fetch from cache if enabled, if cache miss, fetch from actual datasource
      def fetch
        
        caching_enabled = is_caching_enabled()
        if caching_enabled
          result = fetch_from_cache
        end
        
        if !caching_enabled || (caching_enabled && result == nil)
          db_return = query()
          
          result = make_result_object(db_return.columns.as_json, db_return.as_json)
          if caching_enabled
            store_in_cache result
          end
        end
        result
      end
      
      #Get Cache Object (only redis for now)
      def get_cache_object
        return @cache_obj unless @cache_obj == nil
        @cache_obj = ChaiIo::Cache::RedisCache.new
        @cache_obj
      end
      
      
      #Called when caching is enabled
      def fetch_from_cache
        get_cache_object().get make_key
      end
      
      
      def store_in_cache(result)
        get_cache_object().set(make_key, result, @report.cache_time.to_i)
      end
      
      
      def make_key
        params_hash = Digest::MD5.hexdigest(@query_params.to_s)
        "report_#{@report.id}-#{params_hash}"
      end
      
    end
    
  end
end