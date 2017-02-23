class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.cached_all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User created successfully'
    else
      render :new
    end
  end

  def show
    @user.track_vists
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully'
  end

  def fetch_user
    Rack::MiniProfiler.step("fetch user") do
      @user = User.cached_find(params[:id])
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone)
  end
end
