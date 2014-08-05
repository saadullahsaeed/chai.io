class Admin::GlobalDatasourceController < Admin::AdminController
  
  def index
    @datasource = GlobalDatasource.all
  end
  
  def new
  end
  
end
