class StaticPagesController < ApplicationController
  skip_authorization_check
  def home
    @activity = Activity.all_activity(current_user.id).
      order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.paginate.activities if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
