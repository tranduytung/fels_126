class Admin::UsersController < ApplicationController
  # before_action :require_admin
  load_and_authorize_resource

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.paginate.users
  end

  def destroy
    # @user = User.find params[:id]
    if @user.destroy
      flash[:success] = t "message.user_deleted"
    else
      flash[:danger] = t "message.user_not_deleted"
    end
    redirect_to admin_users_path
  end
end