class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: 20
  end

  def show
    @category = Category.find params[:id]
    @lessons = @category.lessons.public_by(current_user)
      .paginate page: params[:page], per_page: 10
    @words = @category.words.paginate page: params[:page], per_page: 20
  end
end
