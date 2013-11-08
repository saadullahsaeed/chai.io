class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def edit
    @user = User.find params[:id]
    render 'new'
  end


  def create
    @user = User.new user_params
    if @user.save
      redirect_to admin_path
    else
      render 'new'
    end
  end


  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      redirect_to admin_path
    else
      render 'new'
    end
  end


  def lock
    User.find(params[:user_id]).lock
    redirect_to admin_users_path
  end


  def unlock
    User.find(params[:user_id]).unlock
    redirect_to admin_users_path
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end