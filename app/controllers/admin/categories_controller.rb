class Admin::CategoriesController < ApplicationController
  before_action :require_admin

  def index
    @categories = Category.paginate page: params[:page], per_page: 20
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "message.new_category_successful"
      redirect_to @category
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :content
  end

end