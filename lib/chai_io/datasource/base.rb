module ChaiIo
  module Datasource  
    
    class Base
      
      attr_accessor :report, :datasource_info, :query_params, :enable_caching
      
      def init
        @cache_obj = nil
      end
      
      def connect
      end
      
      def test_connection(config)
      end
      
      def query
        raise "Method 'query' not implemeneted"
      end
      
      def is_caching_enabled
        @enable_caching && @report.cache_time > 0
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
          Rails.logger.info "Running db query"
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