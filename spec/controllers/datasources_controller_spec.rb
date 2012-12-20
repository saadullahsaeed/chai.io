require 'spec_helper'

describe DatasourcesController do
  
  describe "administrator access" do
    
    before :each do
      @user = create(:user)
      @datasource_type = create(:datasource_type)
      session[:user_id] = @user.id
    end
    
    describe 'GET #index' do
      
        it "renders the :index view" do
          get :index
          response.should render_template :index
        end
    end
    
    describe 'GET #new' do

      it "assigns a new Datasource to @datasource" do
        get :new
        assigns(:datasource).should be_a_new(Datasource)
      end
    end
    
    
    describe "POST #create" do
      
      context "with valid attributes" do

        it "saves the new datasource in the database" do
          expect{
            post :create, datasource: attributes_for(:datasource)
          }.to change(Datasource, :count).by(1)
        end

        it "redirects to the home page" do
          post :create, datasource: attributes_for(:datasource)
          response.should redirect_to '/datasources'
        end
        
      end
    end

    
    describe 'GET #edit' do

      before :each do
        @datasource = create(:datasource, user: @user)
      end

      it "assigns the requested datasource to @datasource" do
        get :edit, id: @datasource
        assigns(:datasource).should eq @datasource
      end

      it "renders the :new template" do
        get :edit, id: @datasource
        response.should render_template :new
      end
    end
    
    
    describe 'PUT #update' do

    	before :each do
    		@datasource = create(:datasource, user: @user, name: 'MyDatasource')
    	end

    	it "locates the requested @datasource" do
    		put :update, id: @datasource, datasource: attributes_for(:datasource)
    		assigns(:datasource).should eq @datasource
    	end

    	context "valid attributes" do
    		it "changes @datasource's attributes" do
    		  put :update, id: @datasource, datasource: attributes_for(:datasource, name: "Updated Name")
    		  @datasource.reload
    		  @datasource.name.should eq "Updated Name"
    		end

    		it "redirects to the datasources listing" do
    		  put :update, id: @datasource, datasource: attributes_for(:datasource)
    		  response.should redirect_to '/datasources'
    		end
    	end
    end
    
  end  
end