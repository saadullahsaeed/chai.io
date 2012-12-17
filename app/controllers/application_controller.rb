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
  
  def auto_login
    redirect_to "/reports" if is_logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  
  def render_404
    render :file => "#{Rails.root}/public/404.html", :status => :not_found
  end
end
