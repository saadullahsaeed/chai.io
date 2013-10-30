class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :authenticate_admin


  def index
    
  end


  private
    def authenticate_admin
      unless current_user.admin
        raise ActionController::RoutingError.new('Not Found')
      end
    end

end
