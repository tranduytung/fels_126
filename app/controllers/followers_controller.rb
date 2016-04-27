class FollowersController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @users = @user.followers.paginate page: params[:page]
  end
end
