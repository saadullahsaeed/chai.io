class ReportsController < ApplicationController
   layout "dashboard"
   
   #GET /reports/:id
   def show
    @id = params[:id]
   end
   
   #GET /reports
   def index
     @active = 'reports'
     @reports = current_user.reports.all
   end
   
   #GET /reports/new
   def new
     
     @active = 'new_report'
     @report = Report.new
     @user = current_user
   end 
   
   
   #POST /reports/create
   def create

     params[:report][:user_id] = current_user.id
     @report = Report.new params[:report]
     
     if @report.save
       redirect_to reports_path
     else
       render :action => 'new'
     end
   end 
   
end
