class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.paginate.users
  end

  def destroy
    @user = User.find params[:id]
    @user.delete_activity
    @user.destroy
    flash[:success] = t "message.user_deleted"
    redirect_to admin_users_path
  end
end