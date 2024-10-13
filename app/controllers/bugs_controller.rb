class BugsController < ApplicationController
    before_action :set_bug, only: %i[show edit update destroy]
    before_action :authenticate_user!
    load_and_authorize_resource # CanCanCan authorization
  
    # GET /bugs
    def index
      @bugs = Bug.all
    end
  
    # GET /bugs/:id
    def show
    end
  
    # GET /bugs/new
    def new
      @bug = Bug.new
    end
  
    # POST /bugs
    def create
      @bug = Bug.new(bug_params)
      @bug.creator_id = current_user.id # QA creating the bug
      if @bug.save
        redirect_to @bug, notice: 'Bug was successfully created.'
      else
        render :new
      end
    end
  
    # GET /bugs/:id/edit
    def edit
    end
  
    # PATCH/PUT /bugs/:id
    def update
      if @bug.update(bug_params)
        redirect_to @bug, notice: 'Bug was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /bugs/:id
    def destroy
      @bug.destroy
      redirect_to bugs_url, notice: 'Bug was successfully destroyed.'
    end
  
    private
  
    def set_bug
      @bug = Bug.find(params[:id])
    end
  
    def bug_params
      params.require(:bug).permit(:title, :description, :deadline, :screenshot, :status, :type, :developer_id, :project_id)
    end
  end
  