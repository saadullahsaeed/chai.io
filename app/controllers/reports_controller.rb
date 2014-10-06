require 'chai_io/report/report'

class ReportsController < DashboardController
  include ChaiIo::Report

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
    @reports = current_project.reports.order('starred DESC, created_at DESC').includes :datasource
    @reports.each do |r|
      r.report_type = r.report_type_text
    end
  end


  #GET /reports/new
  def new
   set_active_menu_item 'new_report'
   @report = current_project.reports.build
   if params[:q] && params[:ds]
     require "base64"
     @report.config['query'] = Base64.decode64 params[:q]
     @report.datasource = current_user.datasources.find params[:ds]
   end

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
   @report = current_project.reports.find params[:id]
   render :action => 'new'
  end


  #PUT /reports/:id
  def update
   @report = current_user.reports.find params[:id]
   if @report.update_attributes report_params
     redirect_to project_reports_path(@report.project)
   else
     render :action => 'new'
   end
  end


  #DELETE /reports/:id
  def destroy
   current_project.reports.find(params[:id]).destroy
   redirect_to project_reports_path current_project
  end


  #GET
  def search
    @query = params[:q].strip
    @reports = current_user.reports.search @query
  end


  #GET
  def starred
    set_active_menu_item 'starred'
    @reports = current_user.reports.all_starred
  end


  #GET
  def shared
    set_active_menu_item 'shared'
    @reports = current_user.reports.all_shared
  end


  #GET
  def tagged_with
    @tag = params[:tag]
    @reports = current_user.reports.tagged_with @tag
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


  #GET
  def star
    report = current_user.reports.find params[:report_id]
    if report.starred
      report.unstar
    else
      report.star
    end
    response = { :success => true }
    respond_to do |format|
        format.json { render :json => response }
    end
  end


  private

    def report_params
      params.require(:report).permit(
        :tag_list,
        :datasource_id, :title, :description, :report_type, :project_id, :cache_time,
        config: [:query, :sum, :average, :link_column, :link_filter, :link_report],
        filters: [:type, :placeholder, :default_value, pd_values: [:title, :value] ])
    end


    def check_embed
      @embed = false
    end

end
