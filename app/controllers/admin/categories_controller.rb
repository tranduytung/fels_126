class Admin::CategoriesController < ApplicationController
  before_action :require_admin
  before_action :find_caregory, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "message.update_category_successful"
      redirect_to @category
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "message.category_deleted"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name, :content
  end

  def find_caregory
    @category = Category.find params[:id]
  end

end