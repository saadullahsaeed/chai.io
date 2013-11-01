class DashboardsController < DashboardController

  def show
    @dashboard = find_dashboard params[:id]
  end


  def index
    @dashboards = current_project.dashboards
  end


  def new
    @dashboard = current_project.dashboards.build
  end


  def create
    @dashboard = current_project.dashboard.build dashboard_params
    if @dashboard.save
      redirect_to project_path(current_project)
    else
      render 'new'
    end 
  end


  def edit
    @dashboard = find_dashboard params[:id]
  end



  private
    def dashboard_params
      params.require(:dashboard).permit(:title)
    end


    def find_dashboard dashboard_id
      current_project.dashboards.find dashboard_id
    end

end
