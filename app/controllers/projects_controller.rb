class ProjectsController < ApplicationController
	layout "dashboard"

	def index
    set_active_menu_item "projects"
		@projects = current_user.projects.all
	end
	
  
	def new 
		@project = current_user.projects.build
	end


	def create
    logger.info project_params
    @project = current_user.projects.build project_params
    if @project.save
        redirect_to projects_path
   	else
     		render :action => 'new'
   	end
	end


  def edit
    @project = current_user.projects.find params[:id]
    render :action => 'new'
  end


  def update
   		@project = current_user.projects.find params[:id]
     	params[:project][:user_id] = current_user.id
     	if @project.update_attributes project_params
       		redirect_to '/projects'
     	else 
       		render :action => 'new'
     	end
  end


  #DELETE /projects/:id
  def destroy
      return if params[:id] == 0
    	current_user.projects.find(params[:id]).destroy
    	redirect_to projects_path
  end


  private

    def project_params
      params.require(:project).permit(:description, :name)
    end


end
