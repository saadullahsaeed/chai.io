class UsersController < DashboardController
  
  #GET /users/:id/edit
  def edit
    set_active_menu_item 'account'
    @user = current_user
  end
  

  #PUT /users/:id
   def update
    current_password = params[:user][:password]
    new_password = params[:user][:new_password]
    new_password_confirm = params[:user][:new_password_confirm]
    flash.now[:error] = "Invalid Password!" unless current_user.authenticate(current_password)
    flash.now[:error] = "Passwords do not match!" unless new_password == new_password_confirm
    if flash.now[:error]
     redirect_to edit_user_path(current_user)
     return
    end
    current_user.password = new_password
    if current_user.save
      flash[:notice] = "Password changed!!"
    end
    redirect_to edit_user_path(current_user)
   end
  
end
