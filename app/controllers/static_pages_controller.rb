class StaticPagesController < ApplicationController
  def home
    @activity = Activity.all_activity(current_user.id).
      order created_at: :desc if logged_in?
    @memoried_words = Word.memoried current_user.id
  end

  def help
  end

  def about
  end

  def contact
  end
end
