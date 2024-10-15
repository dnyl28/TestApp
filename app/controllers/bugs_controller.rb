class BugsController < ApplicationController
  before_action :set_project
  before_action :set_bug, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource # CanCanCan authorization

  # GET /projects/:project_id/bugs
  def index
    @bugs = @project.bugs
  end

  # GET /projects/:project_id/bugs/:id
  def show
  end

  # GET /projects/:project_id/bugs/new
  def new
    @bug = @project.bugs.build
  end

  # POST /projects/:project_id/bugs
  def create
    @bug = @project.bugs.build(bug_params)
    @bug.creator_id = current_user.id # QA creating the bug
    if @bug.save
      redirect_to [@project, @bug], notice: 'Bug was successfully created.'
    else
      render :new
    end
  end

  # GET /projects/:project_id/bugs/:id/edit
  def edit
  end

  # PATCH/PUT /projects/:project_id/bugs/:id
  def update
    if @bug.update(bug_params)
      redirect_to [@project, @bug], notice: 'Bug was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/:project_id/bugs/:id
  def destroy
    @bug.destroy
    redirect_to project_bugs_path(@project), notice: 'Bug was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug = @project.bugs.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :status, :bug_type, :developer_id)
  end
end
