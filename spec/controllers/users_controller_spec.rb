require 'spec_helper'

describe UsersController do
  
  describe 'GET #edit' do
    
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end
    
    it "assigns the current user to @user" do
      get :edit, id: @user
      assigns(:user).should eq @user
    end

    it "renders the :edit template" do
      get :edit, id: @user
      response.should render_template :edit
    end
    
    it "sets active menu item as accounts" do
      get :edit, id: @user
      expect(assigns(:active)).to eq 'account'
    end
  end
  
  
  describe 'PUT #update' do
   
    before :each do
      @user = create(:user, name: "Saad")
      session[:user_id] = @user.id
    end
    
    context "valid attributes" do
      it "changes user password" do
        put :update, id: @user, user: attributes_for(:user, new_password: 'saad2', new_password_confirm: 'saad2')
        @user.reload
        expect(@user.authenticate('saad2')).to_not eq false
      end
      
      it "redirects to the users listing" do
        put :update, id: @user, user: attributes_for(:user)
        response.should redirect_to edit_user_path(@user)
      end
    end
  end
  
  
end
