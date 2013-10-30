class SessionsController < ApplicationController
  
  skip_before_filter :require_login
  
  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password]) && !user.locked
      session[:user_id] = user.id
      redirect_to projects_path, :notice => "Logged in!"
    else
      redirect_to root_url, :notice =>"Invalid email or password"
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
