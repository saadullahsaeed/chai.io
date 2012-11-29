class UsersController < ApplicationController
  layout "dashboard"
  
  #GET /users/:id/edit
  def edit
    set_active_menu_item 'account'
    @user = current_user
  end
  
  #PUT /users/:id
   def update
    
     flash.now[:error] = "Invalid Password!" unless current_user.authenticate(params[:user][:password])
     flash.now[:error] = "Passwords do not match!" unless params[:user][:new_password] == params[:user][:new_password_confirm]
     if flash.now[:error]
       render :action => "edit"
     end
     
     current_user.password = params[:user][:new_password]
     if current_user.save
        flash[:notice] = "Password changed!!"
     end
     
     redirect_to edit_user_path(current_user)
   end
  
end
