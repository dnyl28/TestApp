class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show edit update destroy]
    before_action :authenticate_user!
    load_and_authorize_resource # This is for CanCanCan authorization
  
    # GET /projects
    def index
      @projects = Project.all
    end
  
    # GET /projects/:id
    def show
    end
  
    # GET /projects/new
    def new
      @project = Project.new
    end
  
    # POST /projects
    def create
      @project = Project.new(project_params)
      if @project.save
        puts "Project saved successfully!"
        redirect_to @project, notice: 'Project was successfully created.'
      else
        puts "Failed to save project!"
        puts @project.errors.full_messages
        render :new
      end
    end
    
  
    # GET /projects/:id/edit
    def edit
    end
  
    # PATCH/PUT /projects/:id
    def update
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /projects/:id
    def destroy
      @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    end
  
    private
  
    def set_project
      @project = Project.find(params[:id])
    end
  
    def project_params
      params.require(:project).permit(:title, :description)
    end
  end
  