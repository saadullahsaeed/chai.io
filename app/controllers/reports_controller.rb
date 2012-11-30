class ReportsController < ApplicationController
   layout "dashboard"
   
   #GET /reports/:id
   #To-do: Refactor
   def show
    
    @id = params[:id]
    @report = current_user.reports.find(@id)
    
    datasource_class = ChaiIo::Datasource::Mysql.new
    datasource_class.datasource_info = @report.datasource.config
    connected = datasource_class.connect
    
    @connection_error = false
    @query_error = false
    if !connected
      flash.now[:error] = "Error: Cannot connect to the data source!"
      @connection_error = true
    else
      
      datasource_class.query_str = @report.config['query']
      begin 
        
        result = datasource_class.query
        @columns = result.columns.to_json
        @data = []
        
        case @report.report_type
          
          when 'single_value'
            @name = result.columns.first
            @single_value = result.first[@name]
          when 'bar_chart' || 'pie_chart'
            @data = result
          else
            result.each do |row|
              temp = []
              row.each {|v| temp << v.last}
              @data.push({:values => temp})
            end
        end
        @data = @data.to_json
      
      rescue Sequel::DatabaseError => e
        @data = '[]'
        @columns = '[]'
        @query_error = true
        flash.now[:error] = "Query Error: #{e.message}"
      end
      
    end
    
   end
   
   #GET /reports
   def index
     set_active_menu_item 'reports'
     @reports = current_user.reports.all
   end
   
   
   #GET /reports/new
   def new
     set_active_menu_item 'new_report'
     @report = Report.new
   end 
   
   
   #POST /reports/
   def create

     params[:report][:user_id] = current_user.id
     @report = Report.new params[:report]
     
     if @report.save
       redirect_to '/reports'
     else
       render :action => 'new'
     end
   end 
   
   
   #GET /reports/:id/edit
   def edit
     @report = find_report_for_current_user params[:id]
     render :action => 'new'
   end
   
   
   #PUT /reports/:id
   def update
     @report = find_report_for_current_user params[:id]
     
     if @report.update_attributes params[:report]
       redirect_to_listing
     else 
       render :action => 'new'
     end
   end
   
   
   #DELETe /reports/:id
   def destroy
     find_report_for_current_user(params[:id]).delete
     redirect_to_listing
   end
   
   
   private
   
   def redirect_to_listing
     redirect_to '/reports'
   end
   
   def find_report_for_current_user(id)
     current_user.reports.find id
   end
   
end
