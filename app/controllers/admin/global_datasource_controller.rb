class Admin::GlobalDatasourceController < Admin::AdminController
  
  def index
    @datasource = GlobalDatasource.all
  end
  
  def new
    @datasource = GlobalDatasource.new
  end
  
  def edit
    @datasource = GlobalDatasource.find params[:id]
    render 'new'
  end
  
  def create
    @datasource = GlobalDatasource.new datasource_params
    if @datasource.save
      redirect_to admin_path
    else
      render 'new'
    end
  end
  
  #PUT
  def update
    @datasource = GlobalDatasource.find params[:id]
    if @datasource.update_attributes datasource_params
       redirect_to datasources_path
    else 
       render :action => 'new'
    end
  end
  
  
end
