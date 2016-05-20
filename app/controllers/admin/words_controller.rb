class Admin::WordsController < ApplicationController
  before_action :require_admin
  before_action :find_category, only: [:new, :create]
  before_action :find_word, only: [:edit, :update, :destroy]

  def index
    @words = Word.paginate page: params[:page],
      per_page: Settings.paginate.words
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

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "message.update_word_successful"
      redirect_to [:admin, :words]
    else
      render "edit"
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "message.delete_word_success"
      redirect_to [:admin, :words]
    else
      flash[:danger] = t "message.delete_word_unsuccess"
      redirect_to [:admin, :words]
    end
  end

  private

  def word_params
    params.require(:word).permit :content,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def find_category
    @category = Category.find params[:category_id]
  end

  def find_word
    @word = Word.find params[:id]
  end
end