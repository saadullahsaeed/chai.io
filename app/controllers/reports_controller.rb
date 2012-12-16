require 'timeout'

class ReportsController < ApplicationController
   layout "dashboard"

   #GET /reports/:id
   #To-do: Refactor and move to lib
   def show
    @report = find_report_for_current_user(params[:id])
    
    dsource = get_datasource_object(@report.datasource.config)
    @connected = dsource.connect
    if !@connected
      flash.now[:error] = "Error: Cannot connect to the data source!"
      @connection_error = true
    else
      
      query = @report.config['query']
      dsource.query_str = query
      @query_params = get_query_params(query, @report.filters, params)
      dsource.query_params = @query_params
      
      begin 
        result = dsource.query
        @columns = result.columns.to_json

        Timeout::timeout(10) { @data = get_formatted_data(@report.report_type, result).to_json }
        
      rescue Sequel::DatabaseError => e
        @query_error = true
        flash.now[:error] = "Query Error: #{e.message}"
        
      rescue Timeout::Error => e
        @query_error = true
        flash.now[:error] = "Query timed out. Please fix your query."
      end
      
    end #if
    
    respond_to do |format|
      format.html { render :action => 'show' }
      format.json { render :json => @data }
    end
   end

   
   #GET /reports
   def index
     set_active_menu_item 'reports'
     @reports = current_user.reports.includes(:datasource)
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
       redirect_to_listing
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
     begin
       current_user.reports.find id
     rescue Exception => e
        render :status => 404
     end
   end
   
   
   def get_datasource_object(config)
     dsource = ChaiIo::Datasource::Mysql.new
     dsource.datasource_info = config
     dsource
   end
   
   
   def get_formatted_data(type, result)
     formatter = get_data_formatter(type)
     formatter.data = result
     formatter.format
   end
   
   
   def get_data_formatter(type)
     ChaiIo::Formatter::Base.new
   end
   
   
   #Inject Filters into Query
   def get_query_params(query, filters, params)
     return {} unless filters
     query_params = {}
     filters.each do |i, fi|
       ph = fi['placeholder'].to_sym
       query_params[ph] = params[ph] || default_placeholder_value(fi['type'])
     end
     query_params
   end
   
   
   #Get the default placeholder value
   def default_placeholder_value(ph_type)
    Date.today.to_s
   end
end
