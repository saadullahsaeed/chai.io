module ChaiIo

  module TestHelper
    
    def get_request_with_project action
      get action, :project_id => @project.id
    end

  end
end