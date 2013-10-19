class ReportsController < ApplicationController
   layout "dashboard"
   
   before_filter :require_login, :except => [:public]
   before_filter :check_embed


   #GET /reports/:id
   def show
    begin
      @report = current_user.reports.find params[:id]
      @data = load_report_data @report
      @page_title = "chai.io - #{@report[:title]}"
    rescue Exception => e
      return render_404
    end
    
    respond_to do |format|
      format.html { render :action => 'show' }
      format.json { render :json => @data }
    end
   end
   
   
   #
   def public
    @public_report = true
    public_report = ChaiIo::Export::PublicReport.new
    our_hash = public_report.generate_hash params[:id]
    return render_404 unless our_hash == params[:hash]
    
    @embed = true if params[:embed] == '1'
    @report = Report.find(params[:id]) || raise("not found")
    return render_404 unless @report.sharing_enabled
    
    @data = load_report_data @report
    @report[:user_id] = @report[:config][:query] = @report[:datasource_id] = nil
    @report[:config][:link_report] = nil

    render :action => 'show', :layout => (@embed ? "embedded" : "public")
   end
   
   
   #GET /reports
   def index
     set_active_menu_item 'reports'
     @reports = current_project.reports.includes :datasource
   end
   
   
   #GET /reports/new
   def new
     set_active_menu_item 'new_report'
     @report = current_project.reports.build
     
     redis_config = ChaiIo::Application.config.redis_caching
     @caching_enabled = redis_config[:enabled]
     @default_expiry = redis_config[:default_expiry] if @caching_enabled
   end 
   
   
   #POST /reports/
   def create
     @report = current_project.reports.build report_params
     @report.user = current_project.user
     if @report.save
       redirect_to project_reports_path(current_project)
     else
       render :action => 'new'
     end
   end 

   
   #GET /reports/:id/edit
   def edit
     @report = current_user.reports.find params[:id]
     render :action => 'new'
   end
   

   #PUT /reports/:id
   def update
     @report = current_user.reports.find params[:id]
     if @report.update_attributes report_params
       redirect_to projects_path
     else 
       render :action => 'new'
     end
   end

   
   #DELETE /reports/:id
   def destroy
     current_user.reports.find(params[:id]).destroy
     redirect_to projects_path
   end
   
   
   #GET /reports/:id/share
   def share
     @report = current_user.reports.find params[:report_id]
     unless @report.sharing_enabled
       @report.enable_sharing params[:password]
     end  
     
     public_report = ChaiIo::Export::PublicReport.new
     public_report.report = @report
     
     response = { :public_url => "#{request.protocol}#{request.host_with_port}#{public_report.generate_url}" }
     respond_to do |format|
       format.json { render :json => response }
     end
   end
   
   
   #GET /reports/:id/unshare
   def unshare
     @report = current_user.reports.find params[:report_id]
     @report.disable_sharing
     response = { :unshared => true }
     respond_to do |format|
        format.json { render :json => response }
      end
   end

     
   private

   def report_params
    params.require(:report).permit(
      :datasource_id, :title, :description, :report_type, :project_id, :cache_time,
      config: [:query, :sum, :average, :link_column, :link_filter],
      filters: [:type, :placeholder])
   end
   
   
   # Load report data - need to re-factor this
   def load_report_data(report)
     
     @query_params = get_query_params(report.filters, params)
      
     dsource = get_datasource_object(report)
     dsource.query_params = @query_params
     
     begin
       dsource.run_report
       @columns = dsource.columns.to_json
       @data = dsource.data.to_json
     rescue Sequel::DatabaseError => e
       @query_error = true
       flash.now[:error] = "Query Error: #{e.message}"
     rescue Timeout::Error => e
       @query_error = true
       flash.now[:error] = "Query timed out."
     rescue => e
       flash.now[:error] = "Error: #{e.message}"
       @connection_error = true
     end

     @data
   end
   
   
   def get_datasource_object(report)
     dsource = ChaiIo::Datasource::Mysql.new
     dsource.report = report
     dsource
   end
   
   
   #Inject Filters into Query
   def get_query_params(filters, params)
     return {} unless filters
     query_params = {}
     @filters = []
     filters.each do |i, fi|
       ph = fi['placeholder'].to_sym
       val = params.has_key?(ph) ? params[ph] : fi['default_value'] 
       if ph
         filter_obj = get_filter_object fi['type'], fi['placeholder'], val
         filter_obj.value = val
         if filter_obj.validate
           query_params[ph] = filter_obj.format val
         else
           query_params[ph] = filter_obj.get_default_value
         end
         
         filterX = fi
         filterX['control_type'] = filter_obj.control_type
         @filters << filterX
       end
     end
     query_params
   end
   
   
   #Create an object for the filter
    def get_filter_object(type, placeholder, value)
      fo = eval("ChaiIo::Filter::#{type.capitalize}").new
      fo.value = value
      fo
    end
    

    def check_embed
      @embed = false
    end
end
