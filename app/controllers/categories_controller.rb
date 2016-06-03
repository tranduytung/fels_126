class CategoriesController < ApplicationController
  def index
    unless params[:q].nil?
      params[:q][:lessons_learned_true] = nil if params[:q][:lessons_learned_true] == "0"
    end
    @search = Category.ransack params[:q]
    @categories = @search.result.paginate page: params[:page],
      per_page: Settings.paginate.categories
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.public_by(current_user)
    @words = @category.words.paginate page: params[:page],
      per_page: Settings.paginate.words
  end
end
