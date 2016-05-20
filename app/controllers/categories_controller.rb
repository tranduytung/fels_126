class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.paginate.categories
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.public_by(current_user)
    @words = @category.words.paginate page: params[:page],
      per_page: Settings.paginate.words
  end
end
