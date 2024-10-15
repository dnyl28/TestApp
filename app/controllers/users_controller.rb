class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # CanCanCan authorization

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_type)
  end
end
