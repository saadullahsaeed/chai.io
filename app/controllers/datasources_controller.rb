class DatasourcesController < ApplicationController
  layout "dashboard"
  
  before_filter :set_active_menu

  #GET /datasources/new
  def new  
    @datasource = Datasource.new
  end
  
  def index
    set_active_menu_item "datasources"
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
       return redirect_to '/datasources'
    else 
       return render :action => 'new'
    end
  end
  
  #DELETE /datasources/:id
  def destroy
    current_user.datasources.find(params[:id]).delete
    redirect_to '/datasources'
  end
  
  
  #POST /datasources/test
  def test
    
    dsource = ChaiIo::Datasource::Mysql.new
    connection_works = dsource.test_connection params[:datasource]
    @data = { :success => connection_works }

    respond_to do |format|
       format.json { render :json => @data }
    end
  end
  
  
  private
  
  def set_active_menu
    #set_active_menu_item "datasources"
  end
  
end
