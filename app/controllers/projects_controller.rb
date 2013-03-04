class ProjectsController < ApplicationController
	layout "dashboard"

  before_filter :set_active_menu

	def index
		@projects = current_user.projects.all
    @projects.prepend get_default_project
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
      #return if params[:id] == 0
    	#find_user_project(params[:id]).delete
    	redirect_to '/projects'
   	end


   	private

    def get_default_project
      default_project = Project.new
      default_project.id = 0
      default_project.name = 'Default'
      default_project.reports = current_user.reports.where(:project_id => 0) 
      default_project
    end

   	def find_user_project project_id
   		current_user.projects.find project_id
   	end


    def set_active_menu
      set_active_menu_item "projects"
    end

end
