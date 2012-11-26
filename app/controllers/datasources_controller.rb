class DatasourcesController < ApplicationController
  layout "dashboard"
  
  before_filter :set_active_menu

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
  
  
  #GET /datasources/:id/edit
  def edit
    @datasource = current_user.datasources.find params[:id]
    render :action => "new"
  end
  
  
  #PUT /datasources/:id
  def update
    @datasource = current_user.datasources.find params[:id]
    if @datasource.update_attributes(params[:datasource])
       redirect_to '/datasources'
    else 
       render :action => 'new'
    end
  end
  
  #DELETE /datasources/:id
  def destroy
    current_user.datasources.find(params[:id]).delete
    redirect_to '/datasources'
  end
  
  private
  
  def set_active_menu
    set_active_menu_item "datasources"
  end
  
end
