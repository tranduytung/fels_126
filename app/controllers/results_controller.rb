class ResultsController < ApplicationController
  before_action :logged_in_user
  before_action :find_lesson, only: [:check_user]
  before_action :check_learned, :check_user, only: [:index]
  before_action :check_user, only: [:index]

  def index
    @result = @lesson.results
  end

  private
  def find_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
  end

  def check_learned
    @lesson = Lesson.find_by id: params[:lesson_id]
    unless @lesson.learned?
      flash[:danger] = t "message.lesson_not_learned"
      redirect_to @lesson
    end
  end

  def check_user
    unless current_user? @lesson.user
      flash[:danger] = t "message.you_can_see_it"
      redirect_to @lesson.category
    end
  end
end
