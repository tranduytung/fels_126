class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  # check_authorization

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "message.please_log_in"
      redirect_to login_url
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:danger] = t "message.you_are_not_admin"
      redirect_to root_path
    end
  end
end
