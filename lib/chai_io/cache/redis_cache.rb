require 'redis'

module ChaiIo
  module Cache  
    
    #Redis
    class RedisCache < Base
        
        def get_connection
          return @redis unless @redis == nil
          redis_config = ChaiIo::Application.config.redis_caching
          @redis = Redis.new(:host => redis_config[:host], :port => redis_config[:port])
          @redis
        end
        
        def get(key)
          value = get_connection().get key
          unless value == nil
            value = unserialize(value)
          end
          value
        end  
        
        def set(key, value, expiry)
          get_connection().set key, serialize(value)
          get_connection().expire key, expiry
        end
        
    end
    
  end
end