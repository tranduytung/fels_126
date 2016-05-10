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
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "message.new_word_successful"
      redirect_to @category
    else
      render "new"
    end
  end

  private

  def word_params
    params.require(:word).permit :content,
      answers_attributes: [:content, :is_correct, :_destroy]
  end

  def find_category
    @category = Category.find params[:category_id]
  end
end