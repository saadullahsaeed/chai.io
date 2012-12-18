require 'spec_helper'

describe ReportsController do
  
  describe "administrator access" do
    
    before :each do
      @user = create(:user)
      @datasource = create(:datasource, user: @user)
      session[:user_id] = @user.id
    end
  
    describe 'GET #index' do
      
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #new' do
    
      it "assigns a new Report to @report" do
        get :new
        assigns(:report).should be_a_new(Report)
      end
    
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    
    
    describe 'GET #show' do
      
      before :each do
        @report = create(:report, user: @user, datasource: @datasource)
      end
      
      it "assigns the requested report to @report" do
        get :show, id: @report
        assigns(:report).should eq @report
      end

      it "renders the :show template" do
        get :show, id: @report
        response.should render_template :show
      end
    end
    
    
    describe 'GET #edit' do
      
      before :each do
        @report = create(:report, user: @user)
      end
      
      it "assigns the requested report to @report" do
        get :edit, id: @report
        assigns(:report).should eq @report
      end

      it "renders the :edit template" do
        get :edit, id: @report
        response.should render_template :new
      end
    end
    
    
    describe "POST #create" do
      
      context "with valid attributes" do
        
        it "saves the new report in the database" do
          expect{
            post :create, report: attributes_for(:report)
          }.to change(Report, :count).by(1)
        end
        
        it "redirects to the home page" do
          post :create, report: attributes_for(:report)
          response.should redirect_to '/reports'
        end
        
      end
    end
    
    describe 'PUT #update' do
     
      before :each do
        @report = create(:report, title: "Saads Report", user: @user)
      end
      
      it "locates the requested @report" do
        put :update, id: @report, report: attributes_for(:report)
        assigns(:report).should eq @report
      end
      
      context "valid attributes" do
        it "changes @report's attributes" do
          put :update, id: @report, report: attributes_for(:report, title: "Updated Title")
          @report.reload
          @report.title.should eq "Updated Title"
        end
        
        it "redirects to the reports listing" do
          put :update, id: @report, report: attributes_for(:report)
          response.should redirect_to '/reports'
        end
      end
    end
    
    
    describe "GET #share" do
      
      before :each do
        @report = create(:report, user: @user)
      end
      
      it "sets the sharing_enabled flag to true" do
        get :share, report_id: @report
        assigns(:report).sharing_enabled.should eq true
      end
    end
    
    
    describe "GET #unshare" do
      
      before :each do
        @report = create(:report, user: @user)
      end
      
      it "sets the sharing_enabled flag to false" do
        get :share, report_id: @report
        get :unshare, report_id: @report
        assigns(:report).sharing_enabled.should eq false
      end
    end
    
    describe "GET #public" do
      
      before :each do
        @report = create(:report, user: @user)
      end
      
      context "shared report" do
        get :share, report_id: @report
        
      end
      
      context "unshared report" do
      end
    end

  end #describe admin
  
  
  describe "non-admin access" do
    
    describe 'GET #index' do
      
      it "renders the :index view" do
        get :index
        response.should redirect_to root_url
      end
    end
  end
  
end