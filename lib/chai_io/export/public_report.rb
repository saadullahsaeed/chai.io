require 'chai_io/export/base'

module ChaiIo
  module Export  
    
    class PublicReport < Base
      
      #Return a URL accessible publicly
      def generate_url
        if @report.sharing_enabled
          report_id = @report.id
          md5 = generate_hash(report_id)
          url = "/r/#{@report.id}/#{md5}"
        end
        url
      end
      
      
      def generate_hash(reportId)
        require 'digest/md5'
        Digest::MD5.hexdigest "#{reportId}-#{ChaiIo::Application.config.public_url_secret_token}"
      end   
      
    end #PublicReport
    
  end
end