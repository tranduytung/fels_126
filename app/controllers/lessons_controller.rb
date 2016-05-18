class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_lesson, only: [:show, :update, :check_user, :destroy]
  before_action :find_category, only: [:create]
  before_action :check_user, only: [:show, :update, :destroy]

  def show
  end

  def create
    @lesson = @category.lessons.new user_id: current_user.id
    if @lesson.save
      flash[:success] = t "message.new_lesson_successful"
      redirect_to @lesson
    else
      flash[:danger] = @lesson.errors.full_messages.join
      redirect_to @category
    end
  end

  def update
    @lesson.update_attributes lesson_params
    flash[:success] = t "message.update_lesson_successful"
    redirect_to lesson_results_path @lesson
  end

  def destroy
    @category = @lesson.category
    if @lesson.destroy
      flash[:success] = t "message.delete_lesson_successful"
    else
      flash[:danger] = t "message.delete_lesson_unsuccessful"
    end
    redirect_to @category
  end

  private
  def find_lesson
    @lesson = Lesson.find params[:id]
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
  end

  def lesson_params
    params.require(:lesson).permit :learned,
      results_attributes: [:id, :word_id, :answer_id]
  end

  def check_user
    unless current_user? @lesson.user
      flash[:danger] = t "message.error"
      redirect_to @lesson.category
    end
  end
end
