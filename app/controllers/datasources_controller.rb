class DatasourcesController < ApplicationController
  layout "dashboard"
  
  #GET /datasources/new
  def new
    @datasource = Datasource.new
  end
  
  def index
    
    @datasources = current_user.datasources.all
  end
  
  #POST /datasources/create
  def create
    
     params[:datasource][:user_id] = current_user.id
     @datasource = Datasource.new params[:datasource]
     
     if @datasource.save
       redirect_to datasources_path
     else
       render :action => 'new'
     end
  end

  #GET /datasources
  def show
    logger.debug params
  end
end
