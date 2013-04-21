class ProjectsController < ApplicationController
	layout "dashboard"

  before_filter :set_active_menu

	def index
    set_active_menu_item "projects"
		@projects = current_user.projects.all
	end
	
  
	def new 
		@project = Project.new
	end


	def create
		params[:project][:user_id] = current_user.id
    @project = Project.new params[:project]
     
   	if @project.save
     		redirect_to '/projects'
   	else
     		render :action => 'new'
   	end
	end


  def edit
    @project = find_user_project params[:id]
    render :action => 'new'
  end


  def update
   		@project = find_user_project params[:id]
     
     	params[:project][:user_id] = current_user.id
     	if @project.update_attributes params[:project]
       		redirect_to '/projects'
     	else 
       		render :action => 'new'
     	end
  end


  #DELETE /projects/:id
  def destroy
      return if params[:id] == 0
    	find_user_project(params[:id]).destroy
    	redirect_to '/projects'
  end


  private

   	def find_user_project project_id
   		current_user.projects.find project_id
   	end


    def set_active_menu
      #set_active_menu_item "projects"
    end

end
