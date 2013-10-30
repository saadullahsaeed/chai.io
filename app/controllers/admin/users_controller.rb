class Admin::UsersController < Admin::AdminController


  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def lock
    User.find(params[:user_id]).lock
    redirect_to admin_users_path
  end


  def unlock
    User.find(params[:user_id]).unlock
    redirect_to admin_users_path
  end

end