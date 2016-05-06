class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :destroy]

  def index
    @users = User.paginate page: params[:page], per_page: 20
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "message.wellcome_to"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "message.update_profile"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :picture
  end

  def find_user
    @user = User.find params[:id]
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end
end
