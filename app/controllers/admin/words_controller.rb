class Admin::WordsController < ApplicationController
  before_action :require_admin
  before_action :find_category, only: [:new, :create]
  
  def index
    @words = Word.paginate page: params[:page], per_page: 20
  end

  def new
    @word = @category.words.build
  end

  def create
    @word = @category.words.build category_params
    if @word .answers.select{|answer| answer.is_correct == true}.size != 1
      flash[:error] = t "message.should_have_a_correct_answer"
      render "new"
    elsif @word.save
      flash[:success] = t "message.new_word_successful"
      redirect_to @category
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:word).permit :content,
      answers_attributes: [:content, :is_correct]
  end

  def find_category
    @category = Category.find params[:category_id]
  end

end