class DatasourcesController < DashboardController
  
  #GET /datasources/new
  def new  
    @datasource = current_user.datasources.build
  end
  

  #GET /datasources
  def index
    set_active_menu_item "datasources"
    @datasources = current_user.datasources
  end
  

  #POST /datasources/create
  def create
     @datasource = current_user.datasources.build datasource_params
     if @datasource.save
       redirect_to datasources_path
     else
       render :action => 'new'
     end
  end

  
  #GET /datasources
  def show
  end

  
  #GET /datasources/:id/edit
  def edit
    @datasource = current_user.datasources.find params[:id]
    render :action => "new"
  end
  
  
  #PUT /datasources/:id
  def update
    @datasource = current_user.datasources.find params[:id]
    if @datasource.update_attributes datasource_params
       redirect_to datasources_path
    else 
       render :action => 'new'
    end
  end
  

  #DELETE /datasources/:id
  def destroy
    current_user.datasources.find(params[:id]).delete
    redirect_to datasources_path
  end
  
  
  #POST /datasources/test
  def test
    dsource = ChaiIo::Datasource::Mysql.new
    connection_works = dsource.test_connection datasource_params[:config]
    @data = { :success => connection_works }
    respond_to do |format|
       format.json { render :json => @data }
    end
  end
  
  
  private

    def datasource_params
      params.require(:datasource).permit(:name, :datasource_type_id, config: [:host, :user, :password, :database])
    end
  
end
