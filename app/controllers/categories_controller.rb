class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: 20
  end

  def show
    @category = Category.find params[:id]
    @words = @category.words.paginate page: params[:page], per_page: 20
  end
end
