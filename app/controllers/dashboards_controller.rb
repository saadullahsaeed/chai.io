class DashboardsController < DashboardController

  def show
    @dashboard = find_dashboard params[:id]
  end


  def index
    @dashboards = current_project.dashboards
  end


  def new
    @dashboard = current_project.dashboards.build
    @dashboard.dashboard_reports.build
    @project_reports = current_project.reports
  end


  def create
    @dashboard = current_project.dashboards.build dashboard_params
    @dashboard.user = current_project.user
    if @dashboard.save
      redirect_to project_path(current_project)
    else
      render :new
    end 
  end


  def update
    @dashboard = find_dashboard params[:id]
  end


  private
    def dashboard_params
      params.require(:dashboard).permit(:title, :dashboard_reports_attributes => [:report_id, :report_index])
    end


    def find_dashboard dashboard_id
      current_project.dashboards.find dashboard_id
    end

end
