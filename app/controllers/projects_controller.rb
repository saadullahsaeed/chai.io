class ProjectsController < ApplicationController
  layout "dashboard"
  
   #GET /projects/new
   def new
     @project = Project.new
   end
   
   
   #POST /projects/
    def create
      params[:project][:user_id] = current_user.id
      @project = Project.new params[:project]

      if @project.save
        redirect_to '/projects'
      else
        render :action => 'new'
      end
    end
    
    
    #GET /projects
     def index
       @projects = current_user.projects
     end
     
     
     def show
     end
end
