class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :require_login
  
  private
  
  def require_login
      unless is_logged_in?
        flash[:error] = "You must be logged in to access this section" 
        redirect_to root_url # Prevents the current action from running
      end
  end
  
  def set_active_menu_item(item)
    @active = item
  end
  
  def is_logged_in?
    current_user != nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
end
