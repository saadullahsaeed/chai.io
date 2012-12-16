require 'chai_io/export/base'

module ChaiIo
  module Export  
    
    class PublicReport < Base
      
      #Return a URL accessible publicly
      def generate_url
        if @report.sharing_enabled
          require 'digest/md5'
          md5 = Digest::MD5.hexdigest "#{@report.id}-#{ChaiIo::Application.config.public_url_secret_token}"
          url = "/r/#{@report.id}/#{md5}"
        end
        url
      end
      
    end #PublicReport
    
  end
end