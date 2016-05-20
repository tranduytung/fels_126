class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    if params[:category_id].blank?
      params[:type] = "all_word" if params[:type].nil?
      @words = Word.send params[:type], current_user.id
    else category = @categories.find_by id: params[:category_id]
      @words = category.words.send params[:type], current_user.id
    end
    @words_display = @words.paginate page: params[:page],
      per_page: Settings.paginate.words
  end
end
